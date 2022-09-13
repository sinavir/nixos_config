{ config, ... }:
{
  services.nginx = {
    virtualhosts."kfet.sinavir.fr" = {
      root = ./kfet-proxy-src;
      locations."ws/" = {
        proxyPass = "https://cof.ens.fr/ws/k-fet/open/";
        proxyWebsockets = true;
      };
    };
  };
}
