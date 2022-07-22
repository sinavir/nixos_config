{ ... }:
{
  networking.hostName = "polaris"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.networkmanager.enable = true;
  networking.nameservers = [
        "1.1.1.1"
            "8.8.8.8"
              ];
}
