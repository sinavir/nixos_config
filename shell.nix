{ sourcesUnstable ? import ./nix { unstable = true; }, sourcesStable ? import ./nix { unstable = false; }, pkgs ? import sourcesStable.nixpkgs { }, }:
let
  lib = pkgs.lib;
  mkOpts = s: pkgs.lib.mapAttrsToList (name: path: "-I ${name}=${path}") ({ nixos-config = "/etc/nixos/configuration.nix"; } // s);
in
pkgs.mkShell rec {

  name = "nixos-rebuild-shell";

  packages = with pkgs; [ nixos-rebuild niv ];

  shellHook = ''
    export REBUILD_OPTIONS_STABLE="${lib.concatStringsSep " " (mkOpts sourcesStable)}"
    export REBUILD_OPTIONS_UNSTABLE="${lib.concatStringsSep " " (mkOpts sourcesUnstable)}"
    export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
  '';

}
