# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./host.nix
    ../../base/base.nix
    ../../software/software.nix
    ../../desktop/desktop.nix
    inputs.home-manager.nixosModules.default # Home manager
  ];

  # Select desktop
  desktop.kde.enable = true;
  displayManager.sddm.enable = true;

  # Install nvidia drivers
  graphics.driver.enableNvidia = true;

  # Software
  software.gaming.enable = true; # Enable steam und lutris
  # software.gaming.sunshine.enable = true; # Gives sunshine permissions to capture your screen
  software.vpn.enable = true; # Enable mullvad and other tools

  # Please check if ("amd_iommu=on" or "intel_iommu=on") and "iommu=pt" is set
  # Please change the GPU ids in the virtualization module!
  software.virtualization.enable = true; # Enable qemu and virt-manager
  software.virtualization.cpuType = "amd";
  software.virtualization.hostName = "rafael-pc";

  # Name of the VM that should use GPU-Passthrough
  software.virtualization.guestName = "win10-passthrough";

  # Set username
  main-user.userName = "rafael";
  main-user.userDescription = "Rafael";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Set extraLocaleSettings option
  extra-locate = "de_DE.UTF-8";

  # Configure console keymap
  console.keyMap = "de";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Firewall
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
}
