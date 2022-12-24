{ pkgs, config, lib, ... }: {
  services.nginx = {
    enable = true;
    virtualHosts."10.100.1.2" = {
      default = true;
      root = "/var/lib/proxy.sinavir.fr";
      listen = [{
        addr = "10.100.1.2";
        port = 80;
      }];
      locations = { "/CD_Fanf/" = { extraConfig = "autoindex on;"; }; };
    };
  };
  networking.firewall.interfaces.wg0.allowedTCPPorts = [ 80 ];
}
