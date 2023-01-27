{ ... }:
let
  external = "enp3s2";
  internal = "enp2s0";
in
{

  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true; #Builtin
  networking.interfaces.enp3s2.useDHCP = true; #PCI normal (droite)
  networking.dhcpcd.extraConfig = ''
    # define static profile
    profile static_eth0
    static ip_address=129.199.244.6/23
    static routers=129.199.224.254
    static domain_name_servers=1.1.1.1

    # fallback to static profile on eth0
    interface enp3s2
    fallback static_eth0
  '';

  # NAT
  networking.nat = {
    enable = true;
    internalInterfaces = [ internal ];
    externalInterface = external;
  };
  networking.interfaces.${internal}.ipv4.addresses = [{
    address = "10.0.0.1";
    prefixLength = 24;
  }];
  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      interface=${internal}
      dhcp-range=10.0.0.50,10.0.0.254,255.255.255.0,24h'';
  };
  networking.firewall.trustedInterfaces = [ internal ];
}
