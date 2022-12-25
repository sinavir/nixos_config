{ pkgs, config, lib, ... }: {
  imports = [ <agenix/modules/age.nix> ];
  age.secrets = {
    "ntfy-passwd".file = ./ntfy.age;
  };
}
