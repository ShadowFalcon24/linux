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
  # services.openssh.enable = false; # Enable for remote access if necessary

  networking.hostName = "rafael-pc"; # Define your hostname.

  # Set docker storageDriver to btrfs
  virtualisation.docker.storageDriver = "btrfs";

  # Enable NTFS support
  boot.supportedFilesystems = ["ntfs"];

  # NVME
  fileSystems."/mnt/fast/games" = {
    device = "/dev/disk/by-uuid/676d07a3-96ea-4452-a932-16d764a448f6";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=games"];
  };

  # SSD
  fileSystems."/mnt/ssd/virtualization" = {
    device = "/dev/disk/by-uuid/2e8f5bb1-528f-4a80-9e0a-7769f1e98968";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=virtualization"];
  };

  # HDD
  fileSystems."/mnt/hdd/development" = {
    device = "/dev/disk/by-uuid/9cfca145-d357-427b-b247-63df275332c5";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=development"];
  };
  fileSystems."/mnt/hdd/backups" = {
    device = "/dev/disk/by-uuid/9cfca145-d357-427b-b247-63df275332c5";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=backups"];
  };
  fileSystems."/mnt/hdd/school" = {
    device = "/dev/disk/by-uuid/9cfca145-d357-427b-b247-63df275332c5";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=school"];
  };
}
