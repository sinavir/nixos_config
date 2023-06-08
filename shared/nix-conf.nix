{ lib, pkgs, config, metadata, nodes, name, ... }:
{
  nix.settings.trusted-users = [ "root" "@wheel" ];
}
