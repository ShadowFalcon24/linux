{
  lib,
  config,
  pkgs,
  ...
}: let
  userName = "rafael";
in {
  imports = [
    ../home/nushell.nix # Enable nushell
    ../home/git.nix
    ../home/kde.nix
    ../home/vscode.nix
    ../home/virtualization.nix
  ];

  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  home.packages = with pkgs; [
    moonlight-qt # Install moonlight client
  ];

  software.home = {
    # Git module
    git = {
      enable = true;
      userName = "HttpRafa";
      userEmail = "60099368+HttpRafa@users.noreply.github.com";
    };
    # KDE module
    # Only enable this if we are using KDE
    kde = {
      enable = true;
      background = "spacecraft.jpg";
      theme = "Monochrome";
      iconTheme = "Papirus-Dark";
    };
    # Install vscode for development
    vscode = {
      enable = true;
    };
    # Only enable if we have virtualization with virt-manager enabled
    virtualization.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
