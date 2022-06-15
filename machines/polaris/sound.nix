{ ... }:
{
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = ''
      load-module module-null-sink sink_name=rtp channels=1
      load-module module-rtp-send destination_ip=10.0.0.1 source=rtp.monitor
    '';
  };
}
