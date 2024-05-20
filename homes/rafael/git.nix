{
  lib,
  config,
  pkgs,
  ...
}: {
  # Install git
  programs.git = {
    enable = true;
    userName = "HttpRafa";
    userEmail = "60099368+HttpRafa@users.noreply.github.com";
  };

  # Install github cli
  home.packages = with pkgs; [
    gh
  ];
}
