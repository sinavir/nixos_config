{ sources ? import ./nix { }, pkgs ? import sources.nixpkgs { }, }:
let
  lib = pkgs.lib;
  path = pkgs.lib.mapAttrsToList (name: path: "${name}=${path}") sources;
in pkgs.mkShell rec {

  name = "nixos-rebuild-shell";

  packages = with pkgs; [ niv ];

  shellHook = ''
    export NIX_PATH="${
      lib.concatStringsSep ":"
      ([ "nixos-config=/etc/nixos/configuration.nix" ] ++ path)
    }"
  '';

}
