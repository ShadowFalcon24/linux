# TODO: Add support for sunshine in hooks
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.virtualization;

  # https://github.com/PassthroughPOST/VFIO-Tools/blob/0bdc0aa462c0acd8db344c44e8692ad3a281449a/libvirt_hooks/qemu
  qemuHook = pkgs.writeShellScript "qemu" ''
    #
    # Author: Sebastiaan Meijer (sebastiaan@passthroughpo.st)
    #
    # Copy this file to /etc/libvirt/hooks, make sure it's called "qemu".
    # After this file is installed, restart libvirt.
    # From now on, you can easily add per-guest qemu hooks.
    # Add your hooks in /etc/libvirt/hooks/qemu.d/vm_name/hook_name/state_name.
    # For a list of available hooks, please refer to https://www.libvirt.org/hooks.html
    #

    GUEST_NAME="$1"
    HOOK_NAME="$2"
    STATE_NAME="$3"
    MISC="''${@:4}"

    BASEDIR="$(dirname $0)"

    HOOKPATH="$BASEDIR/qemu.d/$GUEST_NAME/$HOOK_NAME/$STATE_NAME"

    set -e # If a script exits with an error, we should as well.

    # check if it's a non-empty executable file
    if [ -f "$HOOKPATH" ] && [ -s "$HOOKPATH"] && [ -x "$HOOKPATH" ]; then
        eval \"$HOOKPATH\" "$@" 2>&1 | tee -a /var/log/libvirt/custom_hooks.log
    elif [ -d "$HOOKPATH" ]; then
        while read file; do
            # check for null string
            if [ ! -z "$file" ]; then
              eval \"$file\" "$@" 2>&1 | tee -a /var/log/libvirt/custom_hooks.log
            fi
        done <<< "$(find -L "$HOOKPATH" -maxdepth 1 -type f -executable -print;)"
    fi
  '';
in {
  options.software.virtualization = {
    enable = lib.mkEnableOption "enable virtualization software";
    cpuType = lib.mkOption {
      default = "amd";
      description = ''
        amd or intel
      '';
    };
    hostName = lib.mkOption {
      default = "rafael-pc";
      description = ''
        hostname
      '';
    };
    guestName = lib.mkOption {
      default = "win10-passthrough";
      description = ''
        guestname
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # List packages installed in system profile. To search, run:
    # $ nix search neovim
    environment.systemPackages = with pkgs; [
      pciutils # Adds lspci and more
      killall # Required for the teardown script
    ];

    # Enable IOMMU
    boot.kernelParams = ["${cfg.cpuType}_iommu=on" "iommu=pt"];

    # Enable docker
    virtualisation.docker.enable = true;

    # Enable libvirtd
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        package = pkgs.qemu_kvm; # Only allows to emulate host architectures.
        swtpm.enable = true;
        ovmf = {
          enable = true; # Enable OVMF for UEFI
          packages = [pkgs.OVMFFull.fd]; # Enable secureBoot for Windows 11
        };
      };
      onBoot = "ignore";
      onShutdown = "shutdown";

      # Enable better logging
      extraConfig = ''
        log_filters="3:qemu 1:libvirt"
        log_outputs="2:file:/var/log/libvirt/libvirtd.log"
      '';
    };
    systemd.services.libvirtd = {
      # scripts use binaries from these packages
      # NOTE: All these hooks are run with root privileges... Be careful!
      path = with pkgs; [libvirt procps pciutils killall util-linux doas];
      preStart = ''
        mkdir -p /var/lib/libvirt/vbios
        ln -sf ${./../../hosts/${cfg.hostName}/files/gpu-vbios.rom} /var/lib/libvirt/vbios/patched-bios.rom

        mkdir -p /var/lib/libvirt/hooks
        mkdir -p /var/lib/libvirt/hooks/qemu.d/${cfg.guestName}/prepare/begin
        mkdir -p /var/lib/libvirt/hooks/qemu.d/${cfg.guestName}/release/end
        mkdir -p /var/lib/libvirt/hooks/qemu.d/${cfg.guestName}/started/begin

        ln -sf ${qemuHook} /var/lib/libvirt/hooks/qemu
        ln -sf ${./start.sh} /var/lib/libvirt/hooks/qemu.d/${cfg.guestName}/prepare/begin/start.sh
        ln -sf ${./revert.sh} /var/lib/libvirt/hooks/qemu.d/${cfg.guestName}/release/end/revert.sh
      '';
    };

    # Move OVMF files to etc folder
    environment.etc = {
      "ovmf/edk2-x86_64-secure-code.fd" = {
        source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
      };

      "ovmf/edk2-i386-vars.fd" = {
        source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
      };
    };

    # Install virt-manager
    programs.virt-manager.enable = true;
  };
}
