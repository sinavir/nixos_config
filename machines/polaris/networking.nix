{ ... }: {
  networking.hostName = "polaris"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false; # ça bug
  networking.nameservers = [ "1.1.1.1" ];
}
