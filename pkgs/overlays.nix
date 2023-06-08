[
  (self: super: {
    ws-scraper = self.python310Packages.callPackage ./ws-scraper.nix {
      aiosqlite = super.python310Packages.aiosqlite.overrideAttrs (old: {
        propagatedBuildInputs = old.propagatedBuildInputs
          ++ [ self.python310Packages.typing-extensions ];
      });
    };
  })
  (self: super: {
    agenix = self.callPackage ((import ../npins).agenix + "/pkgs/agenix.nix") {};
  })
]
