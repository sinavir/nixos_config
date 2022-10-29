{ pkgs, config, lib, ... }:
{
  imports = [
    <agenix/modules/age.nix>
  ];
  environment.systemPackages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];

  age.secrets = {
    "wg-algedi".file = ./wg-algedi.age;
    "radicale" = {
      file = ./radicale.age;
      owner = "radicale";
      group = "radicale";
    };
  };
}
