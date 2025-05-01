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

  networking.hostName = "shadow-pc"; # Define your hostname.

  # Set docker storageDriver to btrfs
  # virtualisation.docker.storageDriver = "btrfs";

  # Enable NTFS support
  boot.supportedFilesystems = ["ntfs"];
}
