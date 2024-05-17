{
  lib,
  config,
  pkgs,
  ...
}: {
  # Tell virt-manager to use QEMU
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
