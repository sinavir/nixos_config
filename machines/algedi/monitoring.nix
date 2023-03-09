{ lib, pkgs, config, ... }:
{
  services.netdata = {
    enable = true;
    config = {
      web = {
        "bind to" = "10.100.1.2";
      };
    };
    configDir = {
      "stream.conf" = pkgs.writeText "stream.conf" ''
        [eb9e2ae9-a6ae-4737-85d7-aac5fabf8bcf]
          enabled = yes
          default memory mode = dbengine
          health enabled by default = auto
          allow from = 10.100.1.*
      '';
      "go.d.conf" = pkgs.writeText "go.d.conf" ''
        enabled: yes
        modules:
          systemdunits: yes
      '';
    };


  };

  environment.etc."netdata/health_alarm_notify.conf".text = ''
    SEND_CUSTOM="YES"
    DEFAULT_RECIPIENT_CUSTOM="default_recipient"
    custom_sender() {
      local msg="''${host} ''${status_message}: ''${alarm} ''${raised_for}"
      local NTFY_PASS=$(cat ${config.age.secrets."ntfy-passwd".path})
      ${pkgs.curl}/bin/curl \
        -u misc:$NTFY_PASS \
        -H "''${info}" \
        -d "$msg" \
        https://ntfy.sinavir.fr/netdata
    }
  '';
  systemd.services.netdata.environment."NETDATA_DISABLE_CLOUD" = "1";
  networking.firewall.interfaces.wg-main.allowedTCPPorts = [ 19999 ];
  users.users.netdata.extraGroups = [ "ntfy-access" ];
}
