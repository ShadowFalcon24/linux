{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-spacecraft-theme";
  dontBuild = true;
  src = pkgs.fetchFromGitHub {
    owner = "HttpRafa";
    repo = "sddm-spacecraft-theme";
    rev = "2be43d6f869801484357c2dee161ee5f82729ba3";
    sha256 = "0yzyvs854xs3d02988ygk71qd9g9j8s3p3ip4336kzhw5w71a3wv";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
