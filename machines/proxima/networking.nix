{ config, pkgs, lib, ... }:
{
  networking.useDHCP = false;
  networking.interfaces.ens3 = {
    useDHCP = true;
    ipv6.addresses = [{
      address = "2001:41d0:404:200::81a1";
      prefixLength = 128;
    }];
    ipv4.addresses = [{
      address = "51.210.243.54";
      prefixLength = 24;
    }];
  };
  networking.defaultGateway6 = {
    address = "2001:41d0:404:200::1";
    interface = "ens3";
  };
}
