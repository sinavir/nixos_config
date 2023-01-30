[
  (self: super: {
    ms4 = self.libsForQt5.callPackage ./musescore4.nix { };
  })
  (self: super: {
    ws-scraper = self.python310Packages.callPackage ./ws-scraper.nix {
      aiosqlite = super.python310Packages.aiosqlite.overrideAttrs (old: {
        propagatedBuildInputs = old.propagatedBuildInputs
          ++ [ self.python310Packages.typing-extensions ];
      });
    };
  })
]
