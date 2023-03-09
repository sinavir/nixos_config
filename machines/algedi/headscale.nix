{ pkgs, lib, config, ... }:
{
  services.headscale = {
    enable = true;
    port = 8085;
    address = "127.0.0.1";
    settings = {
      dns_config = {
        override_local_dns = true;
        base_domain = "internal";
        magic_dns = true;
        nameservers = [
          "1.1.1.1"
        ];
      };
      server_url = "https://tailscale.m7.rs";
      metrics_listen_addr = "127.0.0.1:8095";
      ip_prefixes = [
        "100.64.0.0/10"
      ];
    };
  };

  services.nginx.virtualHosts = {
    "vpn.sinavir.fr" = {
      forceSSL = true;
      enableACME = true;
      locations = {
        "/" = {
          proxyPass = "http://localhost:${toString config.services.headscale.port}";
          proxyWebsockets = true;
        };
      };
    };
  };
}
