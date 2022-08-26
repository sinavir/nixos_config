{ pkg, config, lib, ...}:
{
  services.nginx = {
    enable = true;
    virtualHosts."ernestophone.fr" = {
      enableACME = true;
      addSSL = true;
      locations."/".return = "302 https://ernestophone.ens.fr";
    };
  };
}
