{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.vpn;
in {
  options.software.vpn = {
    enable = lib.mkEnableOption "enable vpn software";
  };

  config = lib.mkIf cfg.enable {
    # List packages installed in system profile. To search, run:
    # $ nix search neovim
    environment.systemPackages = with pkgs; [
      qbittorrent
      tor-browser
    ];

    # Enable Mullvad VPN
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
