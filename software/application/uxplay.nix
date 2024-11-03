{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.application.uxplay;
in {
  options.software.application.uxplay = {
    enable = lib.mkEnableOption "enable uxplay";
  };

  config = lib.mkIf cfg.enable {
    # Open network ports
    networking.firewall.allowedTCPPorts = [7000 7001 7100];
    networking.firewall.allowedUDPPorts = [5353 6000 6001 7011];

    # To enable network-discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true; # printing
      openFirewall = true; # ensuring that firewall ports are open as needed
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
        domain = true;
      };
    };

    environment.systemPackages = with pkgs; [
      uxplay
    ];
  };
}
