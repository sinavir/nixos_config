let
  lib = (import ../../../nix/mintaka-nixpkgs.nix { }).lib;
  readPubkeys = user:
    builtins.filter (k: k != "") (lib.splitString "\n"
      (builtins.readFile (../../../shared/pubkeys + "/${user}.keys")));
in {
  "wg-mintaka.age".publicKeys = (readPubkeys "maurice")
    ++ (readPubkeys "mintaka");
}
