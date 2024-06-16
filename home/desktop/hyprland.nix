{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.home.hyprland;

  spacecraft-wallpaper = builtins.path {
    path = ../wallpaper/${cfg.background};
  };
in {
  options.software.home.hyprland = {
    enable = lib.mkEnableOption "enable hyprland customizations";
    background = lib.mkOption {
      default = false;
      description = "Background image to use";
      type = with lib.types; uniq str;
    };
    theme = lib.mkOption {
      default = false;
      description = "Theme to use";
      type = with lib.types; uniq str;
    };
    iconTheme = lib.mkOption {
      default = false;
      description = "Icontheme to use";
      type = with lib.types; uniq str;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      papirus-icon-theme # Install Papirus icon theme
      (callPackage ../../nixpkgs/pkgs/monochrome-kde-theme.nix {inherit pkgs;}) # Install Monochrome theme
    ];

    # Enable hyprland home-manager module
    wayland.windowManager.hyprland = {
      enable = true;
    };

    # Install waybar and the wallpaper
    programs.waybar = {
      enable = true;
    };
  };
}
