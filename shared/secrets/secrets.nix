let
  lib = (import <nixpkgs> {}).lib;
  readPubkeys = user: builtins.filter (k: k != "") (lib.splitString "\n" (builtins.readFile (../pubkeys + "/${user}.keys")));
in
{
  "plans-ens.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");
}
