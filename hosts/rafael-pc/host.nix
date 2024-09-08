{
  lib,
  config,
  pkgs,
  ...
}: {
  # Networking
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.hostName = "rafael-pc"; # Define your hostname.

  # Set docker storageDriver to btrfs
  virtualisation.docker.storageDriver = "btrfs";

  # Enable NTFS support
  boot.supportedFilesystems = ["ntfs"];

  # SSD
  fileSystems."/mnt/ssd/games" = {
    device = "/dev/disk/by-uuid/6579cfb8-c7c1-4b10-aa1b-3fc9f64bc6e6";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=games"];
  };
  fileSystems."/mnt/ssd/virtualization" = {
    device = "/dev/disk/by-uuid/6579cfb8-c7c1-4b10-aa1b-3fc9f64bc6e6";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=virtualization"];
  };

  # HDD
  fileSystems."/mnt/hdd/development" = {
    device = "/dev/disk/by-uuid/a485c8a5-fe59-42c2-9cb8-1a510a0940f4";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=development"];
  };
  fileSystems."/mnt/hdd/backups" = {
    device = "/dev/disk/by-uuid/a485c8a5-fe59-42c2-9cb8-1a510a0940f4";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=backups"];
  };
  fileSystems."/mnt/hdd/school" = {
    device = "/dev/disk/by-uuid/a485c8a5-fe59-42c2-9cb8-1a510a0940f4";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=school"];
  };
  fileSystems."/mnt/hdd/games" = {
    device = "/dev/disk/by-uuid/a485c8a5-fe59-42c2-9cb8-1a510a0940f4";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=games"];
  };

  # Extra HDD
  fileSystems."/mnt/extra/images" = {
    device = "/dev/disk/by-uuid/a0acdf1d-5ef9-41d9-8e94-756dccd8e761";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=images"];
  };
}
