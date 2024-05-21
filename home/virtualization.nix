{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.home.virtualization;
in {
  options.software.home.virtualization = {
    enable = lib.mkEnableOption "enable virtualization";
  };

  config = lib.mkIf cfg.enable {
    # Tell virt-manager to use QEMU
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
