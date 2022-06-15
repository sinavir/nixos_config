let
  lib = (import <nixpkgs> {}).lib;
  readPubkeys = user: builtins.filter (k: k != "") (lib.splitString "\n" (builtins.readFile (../pubkeys + "/${user}.keys")));
in
{
  "wg-polaris.age".publicKeys = (readPubkeys "maurice");
}
