{
  lib,
  config,
  pkgs,
  ...
}: {
  systemd.services.pull-updates = {
    description = "Pulls changes to system config";
    restartIfChanged = false;
    startAt = "daily";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    path = [pkgs.git pkgs.openssh];
    script = ''
      test "$(git branch --show-current)" = "main"
      git pull --ff-only
    '';
    serviceConfig = {
      WorkingDirectory = "/etc/nixos/";
      User = config.main-user.userName;
      Type = "oneshot";
    };
  };
}
