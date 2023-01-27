[
  (self: super: {
    ms4 = self.libsForQt5.callPackage ./../../pkgs/musescore4.nix { };
  })
  (self: super: {
    python310Packages.aiosqlite = super.python310Packages.aiosqlite.overrideAttrs (old: {
      propagatedBuildInputs = old.propagatedBuildInputs
        ++ [ self.python310Packages.typing-extensions ];
    });
    ws-scrapper = self.python310Packages.callPackage ./ws-scrapper.nix { };
  })
]
