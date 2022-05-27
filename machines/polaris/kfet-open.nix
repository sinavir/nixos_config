{ pkgs, config, lib, ... }:
{
  systemd.user.services.kfetIndicator = {
    after = [ "network.target" ];
    description = "K-Fêt indicator";
    script = "${pkgs.websocat}/bin/websocat --no-close wss://cof.ens.fr/ws/k-fet/open | ${pkgs.jq}/bin/jq --unbuffered -Rr 'fromjson? | .status?' | sed -u 's/closed/🔴 Close/; s/unknown/🟠 Unknown/; s/opened/🟢 Open/' | xargs -I message ${pkgs.dbus}/bin/dbus-send --dest=i3.status.rs --type=method_call /isKFetOpen i3.status.rs.SetStatus 'string:🍺 message'";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 1;
    };
  };
}
