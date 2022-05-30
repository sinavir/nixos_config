{ pkgs, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."sinavir.fr" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/lib/sinavir.fr";
      locations = {
        "/plans-ens" = {
          basicAuthFile = pkgs.writeText "htpasswd-plans-ens" "admin:$apr1$QV9o3xS.$Xx/Bkv59sBKdumYmC2FW4.";
          extraConfig = "autoindex on;";
        };
      };
    };
  };
}
