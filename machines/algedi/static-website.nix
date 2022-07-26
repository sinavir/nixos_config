{ pkgs, config, lib, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."rz.sinavir.fr" = {
      default = true;
      root = "/var/lib/proxy.sinavir.fr";
      listen = [ {addr = "10.100.1.2"; port = 80; } ];
    };
  };
}
