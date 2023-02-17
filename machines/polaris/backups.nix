{ config, pkgs, lib, ... }:
{
  imports = [ ../../modules/borgmatic.nix ];
  services.btrbk = {
    instances = {
      btrbk = {
        onCalendar = "*-*-* *:00/2:00";
        settings = {
          snapshot_preserve_min = "1d";
          snapshot_preserve = "7d 4w 12m";
          volume."/mnt/btrfs-home-top-lvl" = {
            subvolume = "home";
            snapshot_dir = "btrbk_snapshots";
          };
        };
      };
    };
  };
  services.borgmatic = {
    enable = true;
    startAt = "daily";
    configurations = {
      "home" = {
        location = {
          source_directories = [ "/home" ];
          repositories = [ "ssh://borg@mintaka/~/polaris-home" ];
          exclude_if_present = [ ".nobackup" ];
        };
        retention = {
          keep_daily = 1;
          keep_weekly = 1;
          keep_monthly = 4;
        };
        storage.encryption_passcommand = "cat ${config.age.secrets."bk-passwd".path}";

        hooks.ntfy = {
          topic = "backups";
          server = "https://ntfy.sinavir.fr";
          start = {
            title = "Backup started.";
            message = "${config.networking.hostName} started the home backup";
            tags = "floppy_disk";
            priority = "low";
          };
          finish = {
            title = "Backup successful.";
            message = "${config.networking.hostName} finished the home backup";
            tags = "floppy_disk,heavy_check_mark";
            priority = "low";
          };
          fail = {
            title = "Backup error.";
            message = "${config.networking.hostName} failed on the home backup";
            tags = "floppy_disk,rotating_light";
            priority = "high";
          };
          states = [ "start" "finish" "fail" ];
        };
      };
    };
  };
}
