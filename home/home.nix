{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nushell.nix # Enable nushell
    ./git.nix
    ./vscode.nix
    ./virtualization.nix

    ./desktop/kde.nix
    ./desktop/hyprland.nix
  ];
}
