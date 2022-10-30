{ lib , pkgs, buildPythonApplication, aiosqlite, websockets, fetchFromGitHub }:
buildPythonApplication rec {
  pname = "ws-scraper";
  version = "0.1";
  doCheck = false;
  src = fetchFromGitHub {
    owner = "sinavir";
    repo = "ws-scraper";
    rev = "b719f5791914cf1a57e525a8e8d18b2585c7bea7";
    sha256 = "sha256-5RwqPAcfRpUP0dgF/rTJb1974+tkNarjZ5//nOwmKe8=";
  };
  propagatedBuildInputs = builtins.trace "${aiosqlite}" [ aiosqlite websockets ];
}
