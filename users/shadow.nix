{
  lib,
  config,
  pkgs,
  ...
}: let
  userName = "shadow;

  wallpapers = [
    "heli_1.jpg"
    "rocket_1.jpg"
    "rocket_2.jpg"
    "rocket_3.jpg"
    "other_1.jpg"
    "spacecraft_1.jpg"
    "spacecraft_2.jpg"
    "world_1.jpg"
    "world_2.jpg"
    "world_3.jpg"
  ];

  selectedWallpaper = builtins.elemAt wallpapers 1;
in {
  imports = [
    ../home/home.nix
  ];

  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  software.home = {
    # Git module
    git = {
      enable = true;
      userName = "ShadowFalcon24";
      userEmail = "120450863+ShadowFalcon24@users.noreply.github.com";
    };
    # Hyprland module
    # Only enable this if we are using Hyprland
    hyprland = {
      enable = false;
      background = selectedWallpaper;
      theme = "Monochrome";
      iconTheme = "Papirus-Dark";
    };
    # KDE module
    # Only enable this if we are using KDE
    kde = {
      enable = true;
      background = selectedWallpaper;
      theme = "Monochrome";
      iconTheme = "Papirus-Dark";
    };
    # Install vscode for development
    vscode = {
      enable = true;
    };
    # Only enable if we have virtualization with virt-manager enabled
    virtualization.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
