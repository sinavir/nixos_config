{ pkgs, config, lib, ... }:
let
  wgTopo = import ../../shared/wg-topo.nix;
  wgMain = wgTopo.wg-main;
  peers = lib.filterAttrs (n: v: n != config.networking.hostName) wgMain.peers;
in
{
  networking.useDHCP = false;

  systemd.network = {
    enable = true;
    netdevs = {
      "20-wg-main" = {
        netdevConfig = {
          Name = "wg-main";
          Kind = "wireguard";
        };
        wireguardConfig = {
          ListenPort = wgMain.peers.${config.networking.hostName}.port;
          PrivateKeyFile = config.age.secrets.wg-algedi.path;
        };
        wireguardPeers = lib.mapAttrsToList (peer: conf: { wireguardPeerConfig ={
          inherit (conf) Endpoint PublicKey;
          AllowedIPs = conf.fullIPs;
        };}) peers;
      };
    };
    networks = {
      "20-wg-main" = {
        name = "wg-main";
        address = wgMain.peers.${config.networking.hostName}.IPs;
        routes = builtins.map (net: {
          routeConfig = {
            Destination = net;
          };
        }) wgMain.nets;
      };
      "10-ipv6-uplink" = {
        name = "ens18";
        address = [ "2001:470:1f13:187:b256:8cb7:beb0:9d45/64" ];
        linkConfig.MTUBytes = "1350";
      };
      "10-ipv4-uplink" = {
        name = "ens21";
        address = [ "45.13.104.28/32" ];
        networkConfig = {
          DefaultRouteOnDevice = true;
        };
      };
      "10-dhcppd" = {
        name = "ens20";
        DHCP = "ipv6";
        dhcpv6Config = {
          PrefixDelegationHint="::/60";
          UseDelegatedPrefix = "no";
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
  networking.firewall.allowedUDPPorts = [ 1194 ];
}
