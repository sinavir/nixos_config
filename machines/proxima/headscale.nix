{ config, lib, ... }:
{
  services = {
    headscale = {
      enable = true;
      port = 8085;
      serverUrl = "https://vpn.sinavir.fr";
    };

    nginx.virtualHosts = {
      "vpn.sinavir.fr" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass =
          "http://localhost:${toString config.services.headscale.port}";
      };
    };
  };

  environment.systemPackages = [ config.services.headscale.package ];

}
