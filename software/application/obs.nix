{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.application.obs;
in {
  options.software.application.obs = {
    enable = lib.mkEnableOption "enable obs";
  };

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      # OBS
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
    ];
  };
}
