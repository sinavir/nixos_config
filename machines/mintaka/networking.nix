{ config, lib, pkgs, ... }:
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
        address = [ "129.199.244.6/23" ];
        networkConfig = {
          DefaultRouteOnDevice = true;
        };
      };
      "10-downlink" = {
        name = "enp2s0";
        networkConfig = {
          Address="10.1.1.1/24";
          DHCPServer=true;
          IPMasquerade="ipv4";
        };
        dhcpServerConfig = {
          PoolOffset=100;
          PoolSize=20;
          EmitDNS=true;
          DNS="10.1.1.1";
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
