{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.gaming;
in {
  options.software.gaming = {
    enable = lib.mkEnableOption "enable gaming software";
  };

  config = lib.mkIf cfg.enable {
    # List packages installed in system profile. To search, run:
    # $ nix search vim
    environment.systemPackages = with pkgs; [
      mangohud # Performance Overlay

      # Wine and Lutris
      protonup
      lutris

      # Minecraft
      temurin-bin
      prismlauncher

      # Overrides for Lutris
      (lutris.override {
        extraLibraries = pkgs: [
          # List library dependencies here
        ];
        extraPkgs = pkgs: [
          # List package dependencies here
        ];
      })
    ];

    # Install steam and other fancy things
    programs.steam.enable = true;
    programs.gamemode.enable = true;

    # Set protonup install folder
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
