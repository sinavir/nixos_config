{ ... }:
{
  services.syncthing = {
    user = "maurice";
    group = "maurice";
    dataDir = "/home/maurice";
  };
  networking.firewall.allowedTCPPorts = [ 22000 ];
}
