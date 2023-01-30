{ pkgs, config, lib, ... }:
{
  networking.hostName = "algedi"; # Define your hostname.

  networking.useDHCP = false;
  networking.interfaces.ens18 = {
    useDHCP = true;
    ipv6 = {
      addresses = [{
        address = "2001:470:1f13:187:b256:8cb7:beb0:9d45";
        prefixLength = 64;
      }];
    };
    mtu = 1350;
  };
  networking.interfaces.ens21 = {
    useDHCP = false;
    ipv4 = {
      addresses = [{
        address = "45.13.104.28";
        prefixLength = 32;
      }];
      routes = [{
        address = "0.0.0.0";
        prefixLength = 0;
      }];
    };
  };
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
    "2620:fe::fe"
    "2620:fe::9"
  ];
}
