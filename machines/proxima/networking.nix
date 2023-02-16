{ config, pkgs, lib, ... }:
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
          PrivateKeyFile = config.age.secrets.wg-proxima.path;
        };
        wireguardPeers = lib.mapAttrsToList (peer: conf: { wireguardPeerConfig = {
          inherit (conf) Endpoint PublicKey;
          AllowedIPs = conf.defaultAllowedIPs ++ if peer == "algedi" then [ "::/0" ] else [];
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
  networking.firewall.allowedUDPPorts = [ 1194 ];
}
