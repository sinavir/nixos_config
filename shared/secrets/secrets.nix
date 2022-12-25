let
  lib = (import <nixpkgs> { }).lib;
  readPubkeys = user:
    builtins.filter (k: k != "") (lib.splitString "\n"
      (builtins.readFile (../pubkeys + "/${user}.keys")));
in {
  "ntfy.age".publicKeys = (readPubkeys "maurice") ++ (readPubkeys "mintaka") ++ (readPubkeys "proxima") ++ (readPubkeys "algedi");
}
