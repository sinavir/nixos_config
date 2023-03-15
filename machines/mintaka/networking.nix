{ config, lib, pkgs, ... }:
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
          PrivateKeyFile = config.age.secrets.wg-mintaka.path;
        };
        wireguardPeers = lib.mapAttrsToList
          (peer: conf: {
            wireguardPeerConfig = {
              inherit (conf) PublicKey;
              Endpoint = lib.mkIf (conf.Endpoint != "") conf.Endpoint;
              PersistentKeepalive = lib.mkIf (conf.Endpoint != "") wgMain.peers.${config.networking.hostName}.PersistentKeepalive;
              AllowedIPs = conf.defaultAllowedIPs;
            };
          })
          peers;
      };
    };
    networks = {
      "20-wg-main" = {
        name = "wg-main";
        address = wgMain.peers.${config.networking.hostName}.IPs;
      };
      "10-uplink" = {
        name = "enp3s2";
        address = [ "129.199.224.6/23" ];
        networkConfig = {
          Gateway = "129.199.224.254";
        };
      };
      "10-downlink" = {
        name = "enp2s0";
        networkConfig = {
          Address = "10.1.1.1/24";
          DHCPServer = true;
          IPMasquerade = "ipv4";
        };
        dhcpServerConfig = {
          PoolOffset = 100;
          PoolSize = 20;
          EmitDNS = true;
          DNS = "10.1.1.1";
        };
        linkConfig = {
          RequiredForOnline = false;
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
  networking.firewall.trustedInterfaces = [ "enp2s0" ];
}
