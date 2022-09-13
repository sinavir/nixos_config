{ config, ... }:
{
  services.nginx = {
    virtualHosts."kfet.sinavir.fr" = {
      enableACME = true;
      forceSSL = true;
      root = ./kfet-proxy-src;
      locations."ws/" = {
        proxyPass = "https://cof.ens.fr/ws/k-fet/open/";
        proxyWebsockets = true;
      };
    };
  };
}
