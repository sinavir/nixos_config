{ pkgs, config, lib, ... }:
{
  imports = [
    <agenix/modules/age.nix>
  ];
  environment.systemPackages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];

  age.secrets = lib.mkMerge [
    (lib.mkIf (config.networking.hostName == "polaris") {"wg-polaris".file = ./wg-polaris.age;})



    (lib.mkIf (config.networking.hostName == "algedi") {"wg-algedi".file = ./wg-algedi.age;})


    (lib.mkIf (config.networking.hostName == "proxima") {
      "wg-proxima".file = ./wg-proxima.age;
      "wg-led-proxima".file = ./wg-led-proxima.age;
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
    })


    (lib.mkIf (config.networking.hostName == "mintaka") {"wg-mintaka".file = ./wg-mintaka.age;})
    (lib.mkIf (config.networking.hostName == "algedi") {"radicale".file = ./radicale.age;})


    (lib.mkIf (config.networking.hostName == "elnath") {"wg-elnath".file = ./wg-elnath.age;})
    (lib.mkIf (config.networking.hostName == "elnath") { "keycloakDBPassword".file = ./keycloak-db-password.age;})
    (lib.mkIf (config.networking.hostName == "elnath") { "hackensKey" = {
      file = ./hackens-lan-167-key.age;
      owner = "nginx";
      group = "nginx";
    };
    })
    (lib.mkIf (config.networking.hostName == "elnath") { "mauriceVpnKey" = {
      file = ./maurice-vpn-005-key.age;
      owner = "nginx";
      group = "nginx";
    };
    })
  ];
}
