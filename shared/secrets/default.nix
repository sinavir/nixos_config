{ pkgs, config, lib, ... }:
{
  imports = [
    <agenix/modules/age.nix>
  ];
  environment.systemPackages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];

  age.secrets."wg-polaris".file = lib.mkIf (config.networking.hostName == "polaris") ./wg-polaris.age;
  age.secrets."wg-algedi".file = lib.mkIf (config.networking.hostName == "algedi") ./wg-algedi.age;
  age.secrets."wg-proxima".file = lib.mkIf (config.networking.hostName == "proxima") ./wg-proxima.age;
  age.secrets."wg-mintaka".file = lib.mkIf (config.networking.hostName == "mintaka") ./wg-proxima.age;
}
