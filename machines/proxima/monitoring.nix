{ lib, pkgs, config, ... }:
{
  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "none";
      };
      web = {
        "mode" = "none";
      };
    };
    configDir = {
      "stream.conf" = pkgs.writeText "stream.conf" ''
        [stream]
          enabled = yes
          destination = 10.100.1.2:19999
          api key = eb9e2ae9-a6ae-4737-85d7-aac5fabf8bcf
      '';
      "go.d.conf" = pkgs.writeText "go.d.conf" ''
        enabled: yes
        modules:
          systemdunits: yes
      '';
      "go.d/systemdunits.conf" = pkgs.writeText "systemdunits.conf" ''
        jobs:
          - name: service-units
            include:
              - '*.service'
      '';
    };


  };
  systemd.services.netdata.environment."NETDATA_DISABLE_CLOUD" = "1";
  networking.firewall.interfaces.wg-main.allowedTCPPorts = [ 19999 ];
}
