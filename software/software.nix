{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./sound.nix
    ./gaming.nix
    ./vpn.nix
    ./development.nix
    ./homelab.nix
    ./virtualization/virtualization.nix
    ./application/uxplay.nix
    ./application/ollama.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search <some package>
  environment.systemPackages = with pkgs; [
    # Appimages
    appimage-run

    # File sharing
    localsend # AirDrop alternative

    # Editors
    kate
    obsidian

    # Media editors/players
    mpv # Best media player on linux
    ffmpeg # Video editor
    gimp # Picture editor

    # Networking
    # ciscoPacketTracer8

    # Chat/Voice clients
    vesktop # Discord but better
    teamspeak_client
    # Matrix Client: element-desktop

    # E-Mail clients
    thunderbird

    # Music
    spotify

    # Webbrowser
    google-chrome
    firefox

    # Libreoffice with spell checking for english and german
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE

    # Yubikey
    yubioath-flutter

    # Disk tools
    mediawriter
    parted

    # This is required to be a linux user
    fastfetch
    btop

    # OBS
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
  ];

  # Change some chromium settings
  programs.chromium = {
    enable = true;
    enablePlasmaBrowserIntegration = true;
    extensions = [
      "cimiefiiaegbelhefglklhhakcgmhkai" # Plasma Browser Integration
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden PasswordManager
      "aghfnjkcakhmadgdomlmlhhaocbkloab" # Just Dark Theme
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
      "ifbmcpbgkhlpfcodhjhdbllhiaomkdej" # Office - Enable Copy and Paste
    ];
    extraOpts = {
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "BuiltInDnsClientEnabled" = false;
      "CloudPrintSubmitEnabled" = false;
    };
  };

  # Install partition manager
  programs.partition-manager.enable = true;

  # Install OpenRGB
  services.hardware.openrgb.enable = true;

  # Enable pcscd service
  services.pcscd.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;

  # Run unpatched dynamic binaries
  programs.nix-ld.enable = true;
}
