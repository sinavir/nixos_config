{ pkgs, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (f: p: {
        version = "0.0.20";
        src = pkgs.fetchurl {
          url =
            "https://dl.discordapp.net/apps/linux/${f.version}/discord-${f.version}.tar.gz";
          sha256 = "3f7yuxigEF3e8qhCetCHKBtV4XUHsx/iYiaCCXjspYw=";
        };
      });
    })
  ];
}
