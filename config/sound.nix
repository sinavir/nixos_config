{ ... }:
let
  latency = "50";
in
{
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    systemWide = true;
    extraConfig = "load-module module-rtp-recv latency_msec=${latency} sap_address=0.0.0.0";
  };
}
