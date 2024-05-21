{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.home.sunshine;
in {
  options.software.home.sunshine = {
    server.enable = lib.mkEnableOption "enable sunshine";
    client.enable = lib.mkEnableOption "enable moonlight";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.server.enable {
      systemd.user.services = {
        sunshine = {
          Unit.Description = "Sunshine is a Game stream host for Moonlight.";
          Service.ExecStart = "${pkgs.sunshine}/bin/sunshine";
          Install.WantedBy = ["graphical-session.target"];
        };
      };
    })
    (lib.mkIf cfg.client.enable {
      # Install moonlight
      home.packages = with pkgs; [
        moonlight-qt
      ];
    })
  ];
}
