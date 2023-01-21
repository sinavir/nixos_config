{ sources ? import ./nix { unstable = false; }, pkgs ? import sources.nixpkgs { }, }:
let
  lib = pkgs.lib;
  opts = pkgs.lib.mapAttrsToList (name: path: "-I ${name}=${path}") ({ nixos-config="/etc/nixos/configuration.nix"; } // sources);
in pkgs.mkShell rec {

  name = "nixos-rebuild-shell";

  packages = with pkgs; [ nixos-rebuild niv ];

  shellHook = ''
    export REBUILD_OPTIONS="${lib.concatStringsSep " " opts}"
  '';

}
