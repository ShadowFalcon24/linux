{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.displayManager.sddm;

  custom-wallpaper = builtins.path {
    path = ../../wallpaper/${cfg.background};
  };
in {
  options.displayManager.sddm = {
    enable = lib.mkEnableOption "enable sddm";
    background = lib.mkOption {
      default = false;
      description = "Background image to use";
      type = with lib.types; uniq str;
    };
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];

    environment.systemPackages = [
      (
        pkgs.catppuccin-sddm.override {
          flavor = "mocha";
          font = "JetBrainsMono";
          fontSize = "9";
          background = custom-wallpaper;
          loginBackground = true;
        }
      )
    ];

    # Required for Custom SDDM Themes
    # environment.systemPackages = with pkgs; [
    #  kdePackages.qtsvg
    #  kdePackages.qt5compat
    #  kdePackages.qtdeclarative
    #];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      # theme = "${import ../../nixpkgs/pkgs/sddm-theme.nix {inherit pkgs;}}";
      # theme = "breeze";
    };
  };
}
