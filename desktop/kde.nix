{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.desktop.kde;
in {
  imports = [
    ./displayManager/sddm.nix
  ];

  options.desktop.kde = {
    enable = lib.mkEnableOption "enable kde desktop";
  };

  config = lib.mkIf cfg.enable {
    # Enable home-manager KDE addon if kde is enabled
    home-manager = {
      sharedModules = [inputs.plasma-manager.homeManagerModules.plasma-manager];
    };

    # Enable polkit
    # security.polkit.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.desktopManager.plasma6.enable = true;

    # Fix GTK themes not applied in Wayland
    programs.dconf.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kcalc # Calculator
      vulkan-tools
    ];
  };
}
