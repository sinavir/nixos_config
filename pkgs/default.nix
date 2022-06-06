{ pkgs ? import <nixpkgs> }:
let
  pypkgs = pkgs.python39Packages;
  callPackage = pypkgs.callPackage;
in
{
  crux = callPackage ./crux { inherit callPackage; };
}
