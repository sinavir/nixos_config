{ config, pkgs, lib, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "todo.sinavir.fr".locations."/" = {
        proxy_pass = "http://10.100.1.2:7878";
      };
    };
  };
}
