{ pkg, config, lib, ... }: {
  services.nginx = {
    enable = true;
    virtualHosts."ernestophone.fr" = {
      enableACME = true;
      addSSL = true;
      locations."/".return = "302 https://ernestophone.ens.fr";
    };
    virtualHosts."ernestoburo.ernestophone.fr" = {
      enableACME = true;
      addSSL = true;
      root = ./ernestoburo;
    };
  };
}
