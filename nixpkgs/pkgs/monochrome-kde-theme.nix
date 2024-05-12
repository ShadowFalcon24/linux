{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "monochrome-kde-theme";
  dontBuild = true;
  src = pkgs.fetchFromGitHub {
    owner = "pwyde";
    repo = "monochrome-kde";
    rev = "1c9983e8d1384ec2d9ff0fac59c5265fc74d0e6b";
    sha256 = "1nsffmp0z5a93pwx1jalaiidqrjby9hc1llkxdph9k67cd1i0wcs";
  };
  installPhase = ''
    mkdir -p $out/share/{aurorae,color-schemes,konsole,plasma,themes}
    mkdir $out/share/themes/Monochrome
    cp -r ./aurorae/. $out/share/aurorae
    cp -r ./color-schemes/. $out/share/color-schemes
    cp -r ./konsole/. $out/share/konsole
    cp -r ./plasma/. $out/share/plasma
    cp -r ./gtk/Monochrome/. $out/share/themes/Monochrome
  '';
}
