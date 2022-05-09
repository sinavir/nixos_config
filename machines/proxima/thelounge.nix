{ pkgs, lib, config, ... }:
{
  services.thelounge = {
    enable = true;
    private = true;
    port = 9000;
    extraConfig = {
      reverseProxy = true;
      host = "127.0.0.1";
    };
  };
  virtualHosts."irc.sinavir.fr" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://localhost:9000";
      proxyWebsockets = true;
    };
  };
}
