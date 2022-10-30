{ lib , pkgs, buildPythonApplication, aiosqlite, websockets, fetchFromGitHub }:
buildPythonApplication rec {
  pname = "ws-scraper";
  version = "0.1";
  doCheck = false;
  src = fetchFromGitHub {
    owner = "sinavir";
    repo = "ws-scraper";
    rev = "d9f19ea6b3e7efd5bb06e23c693e303e4c22de0c";
  };
  propagatedBuildInputs = builtins.trace "${aiosqlite}" [ aiosqlite websockets ];
}
