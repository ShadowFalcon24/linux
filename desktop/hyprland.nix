{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.desktop.hyprland;
in {
  imports = [
    ./displayManager/sddm.nix
  ];

  options.desktop.hyprland = {
    enable = lib.mkEnableOption "enable hyprland desktop";
  };

  config = lib.mkIf cfg.enable {
    # Enable hyprland
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      kitty # Terminal Emulator
    ];
  };
}
