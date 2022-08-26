{ pkg, config, lib, ...}:
{
  services.nginx = {
    enable = true;
    virtualHosts."ernestophone.fr" = {
      enableACME = true;
      addSSL = true;
      extraConfig = "return 302 https://fanfare.ens.psl.eu;";
    };
  };
}
