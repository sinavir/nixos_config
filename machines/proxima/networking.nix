{ config, pkgs, lib, ... }:
{
  networking.useDHCP = false;
  networking.interfaces.ens3 = {
    useDHCP = true;
    ipv6.addresses = [{
      address = "2001:41d0:404:200::81a1";
      prefixLength = 128;
    }];
  };
  networking.defaultGateway6 = {
    address = "2001:41d0:404:200::1";
    interface = "ens3";
  };
}
