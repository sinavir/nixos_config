{ lib, pkgs, config, ... }:
let
  path = pkgs.lib.mapAttrsToList (name: path: "${name}=${path}")
    (import ./../nix { unstable = builtins.elem config.networking.hostName [ "algedi" "mintaka" ]; });
in
{
  nix.nixPath = [ "nixos-config=/etc/nixos/configuration.nix" ] ++ path;
  nix.settings.trusted-users = [ "root" "@wheel" ];

  #nixpkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ../pkgs/overlays.nix;
}
