{ pkgs, config, lib, ... }: {
  services.nginx = {
    enable = true;
    virtualHosts."sinavir.fr" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/lib/sinavir.fr";
      locations = {
        "/plans-ens" = {
          # TODO: get them reproducible (must decide how they are stores (in the strore or not ?)
          extraConfig = "autoindex on;";
          basicAuthFile = config.age.secrets.plansPasswd.path;
        };
        "/CD_Fanf" = {
          # TODO: make  reproducible folder
          extraConfig = "autoindex on;";
          basicAuthFile = config.age.secrets.cdFanfPasswd.path;
          proxyPass = "http://10.100.1.2";
        };
      };
    };
  };
}
