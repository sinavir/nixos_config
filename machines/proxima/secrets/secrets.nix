let
  lib = (import <nixpkgs> { }).lib;
  readPubkeys = user:
    builtins.filter (k: k != "") (lib.splitString "\n"
      (builtins.readFile (../../../shared/pubkeys + "/${user}.keys")));
in
{
  "wg-proxima.age".publicKeys = (readPubkeys "maurice")
    ++ (readPubkeys "proxima");
  "plans-passwd.age".publicKeys = (readPubkeys "maurice")
    ++ (readPubkeys "proxima");
  "vaultwarden.age".publicKeys = (readPubkeys "maurice")
    ++ (readPubkeys "proxima");
  "vaultMailPass.age".publicKeys = (readPubkeys "maurice")
    ++ (readPubkeys "proxima");
  "ssoMailPass.age".publicKeys = (readPubkeys "maurice")
    ++ (readPubkeys "proxima");
  "radicale.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");
  "keycloakDatabasePasswordFile.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");
  "keycloak_smtp_password.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "proxima");
}
