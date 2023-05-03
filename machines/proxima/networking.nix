{ config, pkgs, lib, ... }:
{
  networking.useDHCP = false;

  systemd.network = {
    enable = true;
    networks = {
      "10-uplink" = {
        name = "ens3";
        DHCP = "ipv4";
        address = [
          "2001:41d0:404:200::81a1/64"
          "51.210.243.54/32"
        ];
        networkConfig = { Gateway = "2001:41d0:404:200::1"; };
      };
    };
  };
}
