{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.development;
in {
  options.software.development = {
    enable = lib.mkEnableOption "enable development software";
  };

  config = lib.mkIf cfg.enable {
    # List packages installed in system profile. To search, run:
    # $ nix search vim
    environment.systemPackages = with pkgs; [
      # IDEs
      arduino-ide
      jetbrains.gateway

      # File sharing
      filezilla # WinSCP alternative

      # API testing
      postman

      # Kubernetes
      kubectl
      kubernetes-helm

      # 3D Printing
      blender
      orca-slicer

      # Linux headers
      linuxHeaders
    ];
  };
}
