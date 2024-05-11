{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "sddm-spacecraft-theme";
  dontBuild = true;
  src = pkgs.fetchFromGitHub {
    owner = "HttpRafa";
    repo = "sddm-spacecraft-theme";
    rev = "f9d2f54a7f8490bf66293814fc9d1ec6dc277abb";
    sha256 = "1d4bp9fhx1cvqmajqqc72zakw5k6594f0rsgr3lzg9123zv4s7pv";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
