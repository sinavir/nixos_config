let
  lib = (import <nixpkgs> {}).lib;
  readPubkeys = user: builtins.filter (k: k != "") (lib.splitString "\n" (builtins.readFile (../pubkeys + "/${user}.keys")));
in
{
  "wg-algedi.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "algedi");
  "wg-polaris.age".publicKeys = (readPubkeys "maurice");
  "wg-proxima.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");
  "wg-mintaka.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "mintaka");
  #"keycloak-db-password.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "elnath");
  "wg-led-proxima.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");

}
