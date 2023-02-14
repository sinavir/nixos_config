{ pkgs, config, lib, ... }: {
  imports = [ <agenix/modules/age.nix> ];
  environment.systemPackages =
    [ (pkgs.callPackage <agenix/pkgs/agenix.nix> { }) ];

  age.secrets = {
    "wg-algedi" = {
      file = ./wg-algedi.age;
      group = "systemd-network";
      mode = "0440";
    };
    "radicale" = {
      file = ./radicale.age;
      owner = "radicale";
      group = "radicale";
    };
    "cdFanfPasswd" = {
      file = ./cdfanf-passwd.age;
      owner = "nginx";
      group = "nginx";
    };
  };
}
