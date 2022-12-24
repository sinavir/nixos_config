{ lib, pkgs, config, ... }:
let
  path = pkgs.lib.mapAttrsToList (name: path: "${name}=${path}")
    (import ./../nix { unstable = config.nixosIsUnstable; });
in { nix.nixPath = [ "nixos-config=/etc/nixos/configuration.nix" ] ++ path; }
