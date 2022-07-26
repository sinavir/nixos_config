let
  lib = (import <nixpkgs> {}).lib;
  readPubkeys = user: builtins.filter (k: k != "") (lib.splitString "\n" (builtins.readFile (../pubkeys + "/${user}.keys")));
in
{
  "wg-algedi.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "algedi");
  "wg-polaris.age".publicKeys = (readPubkeys "maurice");
  "wg-proxima.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");
  "wg-mintaka.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "mintaka");
  "wg-elnath.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "elnath");
  "keycloak-db-password.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "elnath");
  "wg-led-proxima.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");
  "hackens-lan-167-key.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "elnath");
  "maurice-vpn-005-key.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "elnath");
  "plans-passwd.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");
}
