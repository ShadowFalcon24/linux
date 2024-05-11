{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./sound.nix
    ./gaming.nix
    ./development.nix
    ./vpn.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search <some package>
  environment.systemPackages = with pkgs; [
    # File sharing
    filezilla # WinSCP alternative
    localsend # AirDrop alternative

    # Editors
    kate

    # Media editors/players
    mpv # Best media player on linux
    ffmpeg # Video editor
    gimp # Picture editor

    # Chat clients
    vesktop # Discord but better

    # E-Mail clients
    thunderbird

    # Music
    spotify

    # Webbrowser
    chromium

    # Libreoffice with spell checking for english and german
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE

    # This is required to be a linux user
    fastfetch
  ];

  # Install partition manager
  programs.partition-manager.enable = true;
}
