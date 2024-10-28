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
    ./virtualization/virtualization.nix
    ./application/uxplay.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search <some package>
  environment.systemPackages = with pkgs; [
    # Appimages
    appimage-run

    # Sunshine client
    moonlight-qt

    # File sharing
    filezilla # WinSCP alternative
    localsend # AirDrop alternative

    # Editors
    kate
    obsidian
    arduino-ide
    jetbrains.gateway

    # Media editors/players
    mpv # Best media player on linux
    ffmpeg # Video editor
    gimp # Picture editor

    # 3D Printing
    blender
    orca-slicer

    # Networking
    # ciscoPacketTracer8

    # API testing
    postman

    # Chat clients
    vesktop # Discord but better
    # Matrix Client: element-desktop

    # E-Mail clients
    thunderbird

    # Music
    spotify

    # Webbrowser
    google-chrome

    # Libreoffice with spell checking for english and german
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE

    # Yubikey
    yubioath-flutter

    # Disk tools
    mediawriter
    parted

    # Kubernetes
    kubectl
    kubernetes-helm

    # This is required to be a linux user
    fastfetch
    btop
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
