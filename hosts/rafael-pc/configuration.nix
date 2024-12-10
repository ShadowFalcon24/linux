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
  desktop.hyprland.enable = false; # Disable hyprland
  displayManager.sddm = {
    enable = true;
    background = "spacecraft_2.jpg";
  };

  # Install drivers
  graphics.driver.enableNvidia = false; # Disable for AMD
  graphics.driver.enableAmd = true; # Disable for AMD

  # Software
  software.gaming.enable = true; # Enable steam und lutris
  # software.gaming.sunshine.enable = true; # Gives sunshine permissions to capture your screen
  software.vpn.enable = true; # Enable mullvad and other tools
  software.development.enable = true; # Enable development tools
  software.homelab.enable = true; # Enable homelab tools

  # Applications
  # Ollama
  software.application.ollama = {
    enable = true; # Enable ollama
    gpuAccelerationType = "rocm"; # Set GPU acceleration type / for Nvidia use "cuda"
  };
  # Airplay
  software.application.uxplay.enable = true; # Enable uxplay

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
  networking.firewall.allowedTCPPorts = [
    12892 # Atomic Cloud Controller
    25565 # Minecraft
    53317 # LocalSend
  ];
  networking.firewall.allowedUDPPorts = [
    53317 # LocalSend
  ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
}
