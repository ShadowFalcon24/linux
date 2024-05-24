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
  #fileSystems."/mnt/ssd/games" = {
  #  device = "/dev/disk/by-uuid/e1540e91-621f-4c63-b575-3646be321078";
  #  fsType = "btrfs";
  #  options = ["compress=zstd" "subvol=games"];
  #};
  #fileSystems."/mnt/ssd/virtualization" = {
  #  device = "/dev/disk/by-uuid/e1540e91-621f-4c63-b575-3646be321078";
  #  fsType = "btrfs";
  #  options = ["compress=zstd" "subvol=virtualization"];
  #};

  # HDD
  fileSystems."/mnt/hdd/development" = {
    device = "/dev/disk/by-uuid/8ded14ae-3f13-4112-bdff-bb4cd4bb9d1e";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=development"];
  };
  fileSystems."/mnt/hdd/backups" = {
    device = "/dev/disk/by-uuid/8ded14ae-3f13-4112-bdff-bb4cd4bb9d1e";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=backups"];
  };
  fileSystems."/mnt/hdd/school" = {
    device = "/dev/disk/by-uuid/8ded14ae-3f13-4112-bdff-bb4cd4bb9d1e";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=school"];
  };

  # Extra HDD
  fileSystems."/mnt/extra/other" = {
    device = "/dev/disk/by-uuid/9e4a24de-8d5c-47cc-a5e2-e1774145ce7e";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=other"];
  };
  fileSystems."/mnt/extra/images" = {
    device = "/dev/disk/by-uuid/9e4a24de-8d5c-47cc-a5e2-e1774145ce7e";
    fsType = "btrfs";
    options = ["compress=zstd" "subvol=images"];
  };
}
