{ ... }:
{
  imports = [ ../../modules/zerobin.nix ];
  disabledModules = [ "services/networking/zerobin.nix" ]; 
  services.zerobin = {
    enable = true;
    listenPort = 1333;
  };
  services.nginx.enable = true;
  services.nginx.virtualHosts."bin.sinavir.fr" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://localhost:1333";
    };
  };
}
