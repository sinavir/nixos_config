{ config, pkgs, lib, ... }:
{
  services.keycloak = {
    enable = true;
    database.passwordFile = config.age.secrets."keycloakDBPassword".path;
    settings = {
      hostname = "192.168.1.167";
      proxy = "edge";
      http-port = 8080;
      http-host = "localhost";
      http-enabled = true;
      log-level = "debug";
    };
    initialAdminPassword = "changeme";
  };
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."192.168.1.167" = {
      listen = [{ addr = "192.168.1.167"; port = 443; ssl = true; }];
      addSSL = true;
      sslCertificate = ../../shared/hackens-lan-167.crt;
      sslCertificateKey = config.age.secrets.hackensKey.path;
      locations."/" = {
        proxyPass = "http://localhost:8080";
      };
    };
    virtualHosts."10.100.1.5" = {
      listen = [{ addr = "10.100.1.5"; port = 443; ssl = true; }];
      addSSL = true;
      sslCertificate = ../../shared/maurice-vpn-005.crt;
      sslCertificateKey = config.age.secrets.mauriceVpnKey.path;
      locations."/" = {
        proxyPass = "http://localhost:8080";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
