{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./kde.nix
    ./displayManager/sddm.nix
    ./displayManager/lightdm.nix
  ];
}
