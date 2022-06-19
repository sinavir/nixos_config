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
    (lib.mkIf (config.networking.hostName == "proxima") {"wg-proxima".file = ./wg-proxima.age;})
    (lib.mkIf (config.networking.hostName == "mintaka") {"wg-mintaka".file = ./wg-proxima.age;})
    #(lib.mkIf (config.networking.hostName == "elnath") { "keycloakDBPassword".file = ./keycloak-db-password.age;})
    (lib.mkIf (config.networking.hostName == "proxima") {"wg-led-proxima".file = ./wg-led-proxima.age;})
    (lib.mkIf (config.networking.hostName == "mintaka") {"wg-mintaka".file = ./wg-mintaka.age;})
  ];
}
