{ pkgs, config, lib, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."sinavir.fr" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/lib/sinavir.fr";
      locations = {
        "/plans-ens" = {
          extraConfig = "autoindex on;";
	  basicAuthFile = config.age.secrets.plansPasswd.path;
        };
        "/rz" = {
          proxyPass = "http://10.100.1.2";
        };
      };
    };
  };
}
