{ ... }:
{
  networking.hostName = "polaris"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.networkmanager.enable = true;

  me.lan = {
    ipv4 = "10.100.0.3";
    prefixSize4 = 24;
    ipv6 = "2001:470:1f13:128::3";
    prefixSize6 = 64;
  };
}
