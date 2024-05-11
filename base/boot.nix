{
  lib,
  config,
  pkgs,
  ...
}: {
  # OLD: Change kernel to the zen kernel
  #boot.kernelPackages = pkgs.linuxPackages_zen;

  # Change kernel to the CachyOS kernel
  # Switch to new scheduler: sudo scx_rusty
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  environment.systemPackages = [pkgs.scx];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
