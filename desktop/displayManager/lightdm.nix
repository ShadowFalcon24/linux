{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.displayManager.lightdm;
in {
  options.displayManager.lightdm = {
    enable = lib.mkEnableOption "enable lightdm";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.displayManager.lightdm = {
      enable = true;
    };
  };
}
