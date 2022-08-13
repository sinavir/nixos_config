{ pkgs, lib, config, ... }:
{
  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 900; command = "${pkgs.swaylock}/bin/swaylock"; }
      {
        timeout = 120;
        command = "swaymsg \"output * dpms off\"";
        resumeCommand = "swaymsg \"output * dpms on\"";
      }
    ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock"; }
    ];
  };
}
