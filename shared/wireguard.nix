{ pkgs, config, ... }:
# Range d'ipv6 de HE: 2001:470:1f13:128::/64
let
  peers = [
        {
          publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/algedi);
          allowedIPs = [ "10.100.0.2/32" "2001:470:1f13:128::2/128" ];
          endpoint = "rz.sinavir.fr:51820";
        }
        #{
        #  publicKey = "keys/mintaka";
        #  allowedIPs = [ "10.100.0.3/32" "2001:470:1f13:128::3/128" ];
        #}
        {
          publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./wg_keys/proxima);
          allowedIPs = [ "10.100.0.1/32" "2001:470:1f13:128::1/128" ];
          endpoint = "sinavir.fr:51820";
        }
      ];
in
{
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "${config.me.lan.ipv4}/${toString config.me.lan.prefixSize4}" "${config.me.lan.ipv6}/${toString config.me.lan.prefixSize6}" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/var/lib/wg/private";

      inherit peers;
    };
  };
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
}
