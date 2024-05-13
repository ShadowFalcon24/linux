{
  lib,
  config,
  pkgs,
  ...
}: let
  spacecraft-wallpaper = builtins.path {
    path = ./wallpapers/spacecraft.jpg;
  };
in {
  home.packages = with pkgs; [
    papirus-icon-theme # Install Papirus icon theme
    (callPackage ../../nixpkgs/pkgs/monochrome-kde-theme.nix {inherit pkgs;}) # Install Monochrome theme
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select";
      theme = "Monochrome";
      colorScheme = "Monochrome";
      lookAndFeel = "Monochrome";
      iconTheme = "Papirus-Dark";
      wallpaper = spacecraft-wallpaper;
    };

    configFile = {
      kscreenlockerrc = {
        Greeter.WallpaperPlugin = "org.kde.image";
        "Greeter/Wallpaper/org.kde.image/General".Image = spacecraft-wallpaper;
      };
    };
  };
}
