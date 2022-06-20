{ config, lib, pkgs, ... }:
let
  conf = pkgs.writeTextFile "config.php" ''
  '';
{
  options = {
    pkg = lib.mkOption {
      type = lib.types.path;
      default = import ./kanboard-pkg.nix { inherit pkgs; config = conf; };
      description = "The kanboard package to use";
    }
    conf = {
      
