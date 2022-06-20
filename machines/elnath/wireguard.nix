{ pkgs, config, ... }:
{
  imports = [ ../../shared/shared.nix ];
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "${config.shared.wg.all4}5/24" "${config.shared.wg.all6}5/64" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets."wg-${config.networking.hostName}".path;
      peers = [
        (config.shared.wg.peers.proxima)
        (config.shared.wg.peers.polaris)
      ];
    };
  };
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
}
