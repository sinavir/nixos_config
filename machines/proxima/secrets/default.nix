{ pkgs, config, lib, ... }:
{
  imports = [
    <agenix/modules/age.nix>
  ];
  environment.systemPackages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];

  age.secrets = {
    "wg-proxima".file = ./wg-proxima.age;
    "plansPasswd" = {
      file = ./plans-passwd.age;
      owner = "nginx";
      group = "nginx";
    };
    "cdFanfPasswd" = {
      file = ./cdfanf-passwd.age;
      owner = "nginx";
      group = "nginx";
    };
    "vaultwarden.env" = {
      file = ./vaultwarden.age;
      owner = "vaultwarden";
      group = "vaultwarden";
    };
  };
}
