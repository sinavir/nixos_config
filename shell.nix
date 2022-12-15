{
  pkgs ? import ./nix/current-nixos.nix {},
  path ? import ./nix/current-path.nix,
}:
let lib = pkgs.lib;
in pkgs.mkShell rec {

  name = "nixos-rebuild-shell";

  packages = with pkgs; [
    niv
    nix
  ];

  shellHook = ''
    export NIX_PATH="${lib.concatStringsSep ":" path}"
  '';

}
