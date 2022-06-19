{ ... }:
{
  nixpkgs.overlays = [ 
    (self: super:
      {
        zlib = super.zlib.overrideAttrs (old: { patches = (old.patches or []) ++ [ ./crc-patch.patch ];});
      }
    )
  ];
}
