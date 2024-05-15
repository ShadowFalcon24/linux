{
  lib,
  config,
  pkgs,
  ...
}: {
  # OLD: Change kernel to the zen kernel
  #boot.kernelPackages = pkgs.linuxPackages_zen;

  # Change kernel to the CachyOS kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  chaotic.scx.enable = true; # by default uses scx_rustland scheduler
  # chaotic.scx.scheduler = "scx_rusty";

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
    netbootxyz.enable = true;
  };
}
