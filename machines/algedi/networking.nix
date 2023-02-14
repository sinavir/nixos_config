{ pkgs, config, lib, ... }:
{
  networking.useDHCP = false;

  systemd.network = {
    enable = true;
    networks = {
      "ipv6-uplink" = {
        name = "ens18";
        address = [ "2001:470:1f13:187:b256:8cb7:beb0:9d45/64" ];
        linkConfig.MTUBytes = "1350";
      };
      "ipv4-uplink" = {
        name = "ens21";
        address = [ "45.13.104.28/32" ];
        networkConfig = {
          DefaultRouteOnDevice = true;
        };
      };
    };
  };
  networking.nameservers = [
    "2620:fe::fe"
    "2620:fe::9"
    "9.9.9.9"
    "149.112.112.112"
  ];
}
