{ lib, pkgs, buildPythonApplication, python310Packages, fetchFromGitHub }:
buildPythonApplication rec {
  pname = "";
  version = "1.0";
  doCheck = false;
  src = fetchFromGitHub {
    owner = "sinavir";
    repo = "resilient-websocat";
    rev = "c13e7f5d60f5c31b63d0b7ac638f6df5211c265c";
    sha256 = "0e2dd10273a5a3c43a9db94d4ac35f0736787f09a7868cbdc0f01d06facb44ef";
  };
  propagatedBuildInputs = [ pkgs.python310Packages.websockets ];
}
