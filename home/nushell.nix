{
  lib,
  config,
  pkgs,
  ...
}: {
  # Install nushell
  programs = {
    nushell = {
      enable = true;
      extraConfig = ''
        $env.config = {
          show_banner: false,
        }
      '';
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
    };
  };
}
