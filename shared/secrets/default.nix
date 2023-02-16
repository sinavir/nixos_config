{ pkgs, config, lib, ... }: {
  imports = [ <agenix/modules/age.nix> ];
  age.secrets = {
    "ntfy-passwd" = {
      file = ./ntfy.age;
      group = "ntfy-access";
      mode = "0440";
    };
  };
  users.groups."ntfy-access" = {};
}
