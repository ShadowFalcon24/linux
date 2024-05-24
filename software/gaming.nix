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
    sunshine.enable = lib.mkEnableOption "enable sunshine capabilities";
  };

  config = lib.mkMerge [
    (
      lib.mkIf cfg.enable {
        # List packages installed in system profile. To search, run:
        # $ nix search vim
        environment.systemPackages = with pkgs; [
          mangohud # Performance Overlay

          # Wine and bottles
          # protonup
          # wineWowPackages.stable
          # winetricks
          # bottles

          # Minecraft
          temurin-bin
          prismlauncher
        ];

        # Install steam and other fancy things
        # programs.steam.enable = true;
        programs.gamemode.enable = true;

        # Set protonup install folder
        # environment.sessionVariables = {
        #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
        # };
      }
    )
    (lib.mkIf cfg.sunshine.enable {
      services.sunshine = {
        package = pkgs.sunshine.override {
          cudaSupport = true;
        };
        enable = true;
        capSysAdmin = true;
      };
    })
  ];
}
