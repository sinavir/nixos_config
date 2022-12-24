{ lib, buildPythonPackage, fetchFromGitHub }:
buildPythonPackage rec {
  pname = "bottom";
  version = "3.0.0";
  src = fetchFromGitHub {
    owner = "sinavir";
    repo = "bottom";
    rev = "b0c0625e6a05157feb6ac95833788955bd0bcfc7";
    sha256 = "1f3vb1p82hs541x3ms0rrjja659h1yf026pzs75632sqdm9sykzl";
  };
  doCheck = false;
  meta = with lib; {
    description = "asyncio-based rfc2812-compliant python IRC Client (3.8+)";
    homepage = "https://github.com/numberoverzero/bottom/";
    license = licenses.mit;
  };
}
