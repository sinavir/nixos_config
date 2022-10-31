{ lib , pkgs, buildPythonApplication, aiosqlite, websockets, fetchFromGitHub }:
buildPythonApplication rec {
  pname = "ws-scraper";
  version = "0.1";
  doCheck = false;
  src = fetchFromGitHub {
    owner = "sinavir";
    repo = "ws-scraper";
    rev = "b766503db4653a3566a079a2462deb775606b130";
    sha256 = "sha256-huchXhYvXjAxep/8gQC5L4LECN+WJXpSlXSARWZxw9Y=";
  };
  propagatedBuildInputs = builtins.trace "${aiosqlite}" [ aiosqlite websockets ];
}
