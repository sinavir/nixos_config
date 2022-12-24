{ unstable ? false }:
let
  sources = import ./sources.nix;
  nixos = if unstable then sources.nixos-unstable else sources.nixos-stable;
in {
  inherit (sources) agenix home-manager;
  inherit nixos;
  nixpkgs = nixos;
}
