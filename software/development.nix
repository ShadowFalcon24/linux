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
    # $ nix search neovim
    environment.systemPackages = with pkgs; [
      # Editors
      neovim
      jetbrains-toolbox
      vscode

      # Git
      git
      gh

      # Rust
      rustup

      # Java
      temurin-bin
      gradle
    ];
  };
}
