{ pkgs, lib, config, ... }:
let
  headscaleUi = pkgs.callPackage ./headscale-ui { };
in
{
  services.headscale = {
    enable = true;
    port = 8085;
    address = "127.0.0.1";
    settings = {
      dns_config = {
        override_local_dns = true;
        base_domain = "";
        magic_dns = true;
        nameservers = [
          "1.1.1.1"
        ];
      };
      server_url = "https://vpn.sinavir.fr";
      #metrics_listen_addr = "127.0.0.1:8095";
      ip_prefixes = [
        "10.111.0.0/16"
      ];
      oidc = {
        issuer = "auth.sinavir.fr";
        client_id = "headscale";
        client_secret_path = config.age.secrets."oidc_headscale_secret".path;
      };
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
  environment.systemPackages = [ pkgs.headscale ];
}
