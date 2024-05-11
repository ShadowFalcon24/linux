{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.displayManager.sddm;
in {
  options.displayManager.sddm = {
    enable = lib.mkEnableOption "enable sddm";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];

    environment.systemPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qt5compat
      kdePackages.qtdeclarative
    ];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${import ../../nixpkgs/pkgs/sddm-spacecraft-theme.nix {inherit pkgs;}}";
      #theme = "breeze";
    };
  };
}
