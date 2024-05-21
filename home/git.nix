{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.home.git;
in {
  options.software.home.git = {
    enable = lib.mkEnableOption "enable git";
    userName = lib.mkOption {
      default = false;
      description = "Username used by GIT to commit";
      type = with lib.types; uniq str;
    };
    userEmail = lib.mkOption {
      default = false;
      description = "E-Mail used by GIT to commit";
      type = with lib.types; uniq str;
    };
  };

  config = lib.mkIf cfg.enable {
    # Install git
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
    };

    # Install github cli
    home.packages = with pkgs; [
      gh
    ];
  };
}
