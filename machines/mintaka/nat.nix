{ ... }:
let
  external = "enp3s2";
  internal = "enp2s0";
in
{
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
