{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.main-user;
in {
  options.main-user = {
    userName = lib.mkOption {
      default = "mainuser";
      description = "Username";
    };
    userDescription = lib.mkOption {
      default = "Main User";
      description = "Description of the user";
    };
  };

  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."${cfg.userName}" = {
      isNormalUser = true;
      description = cfg.userDescription;
      extraGroups = ["networkmanager" "wheel" "libvirtd" "docker" "wireshark" "dialout"];
      shell = pkgs.nushell;
      packages = with pkgs; []; # User packages
    };

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "${cfg.userName}" = import ../users/${cfg.userName}.nix;
      };
    };
  };
}
