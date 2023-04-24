{ pkgs, config, lib, ... }:
{
  services.convos = {
    enable = true;
    reverseProxy = true;
    listenPort = 4444;
    listenAddress = "127.0.0.1";
  };
  services.nginx.virtualHosts."irc-beta.sinavir.fr" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:4444";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_set_header  X-Request-Base "$scheme://$host/";
      '';
    };
  };
}
