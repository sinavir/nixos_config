{ pkgs, config, ... }:
{
  imports = [ ../../shared/shared.nix ];
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "${config.shared.wg.all4}1/24" "${config.shared.wg.all6}1/64" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets."wg-${config.networking.hostName}".path;
      peers = [
        config.shared.wg.peers.algedi
        config.shared.wg.peers.polaris
        config.shared.wg.peers.mintaka
        config.shared.wg.peers.elnath
      ];
    };
    wg-led = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.5.2/24" ];
      listenPort = 51845;
      privateKeyFile = config.age.secrets."wg-led-proxima".path;
      peers = [
        config.shared.wg.peers.ap-unifi
      ];
    };
  };
  networking.firewall.trustedInterfaces = [ "wg-led" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 51845 ]; # Clients and peers can use the same port, see listenport
  };
}
