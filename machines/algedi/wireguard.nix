{ pkgs, config, ... }:
{
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "${config.shared.wg.all4}2/24" "${config.shared.wg.all6}2/64" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets."wg-${config.networking.hostName}".path;
      peers = [
        config.shared.wg.peers.proxima
      ];
    };
  };
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
}
