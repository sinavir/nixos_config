{ pkgs }:
pkgs.python310Packages.callPackage ./ws-scraper.nix {
  aiosqlite = pkgs.python310Packages.aiosqlite.overrideAttrs (old:{
    propagatedBuildInputs = old.propagatedBuildInputs ++ 
      [ pkgs.python310Packages.typing-extensions ];
  });
}
