{ pkg, config, lib, ...}:
{
  services.nginx = {
    enable = true;
    virtualHosts."ernestophone.fr".extraConfig = "return 302 https://ernestophone.ens.psl.eu";
  };
}
