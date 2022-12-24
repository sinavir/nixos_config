{ config, pkgs, lib, ... }:
with lib;
let cfg = config.services.zerobin;
in {
  options = {
    services.zerobin = {
      enable = mkEnableOption "0bin";

      dataDir = mkOption {
        type = types.str;
        default = "/var/lib/zerobin";
        description = ''
          Path to the 0bin data directory
        '';
      };

      user = mkOption {
        type = types.str;
        default = "zerobin";
        description = ''
          The user 0bin should run as
        '';
      };

      group = mkOption {
        type = types.str;
        default = "zerobin";
        description = ''
          The group 0bin should run as
        '';
      };

      listenPort = mkOption {
        type = types.int;
        default = 8000;
        example = 1357;
        description = ''
          The port zerobin should listen on
        '';
      };

      listenAddress = mkOption {
        type = types.str;
        default = "localhost";
        example = "127.0.0.1";
        description = ''
          The address zerobin should listen to
        '';
      };
    };
  };

  config = mkIf (cfg.enable) {
    users.users.${cfg.user} = if cfg.user == "zerobin" then {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.dataDir;
      createHome = true;
    } else
      { };
    users.groups.${cfg.group} = { };

    systemd.services.zerobin = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart =
        "${pkgs.zerobin}/bin/zerobin --host ${cfg.listenAddress} --port ${
          toString cfg.listenPort
        }";
      serviceConfig.PrivateTmp = "yes";
      serviceConfig.User = cfg.user;
      serviceConfig.Group = cfg.group;
      preStart = ''
        mkdir -p ${cfg.dataDir}
        chown ${cfg.user} ${cfg.dataDir}
      '';
    };
  };
}
