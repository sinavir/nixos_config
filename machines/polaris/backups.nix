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
    beforeAllScript = "export NTFY_PASSWORD=$(cat ${config.age.secrets."ntfy-passwd".path})";
    preValidationScript = "export NTFY_PASSWORD=";
    configurations = {
      "home" = {
        storage.ssh_command = "ssh -i /home/maurice/.ssh/id_ed25519";
        location = {
          source_directories = [ "/mnt/btrfs-home-top-lvl/home-borgmatic-snapshot" ];
          repositories = [ "ssh://borg@10.100.1.4/./polaris-home" ];
          exclude_if_present = [ ".nobackup" ];
        };
        retention = {
          keep_daily = 1;
          keep_weekly = 1;
          keep_monthly = 4;
        };
        storage.encryption_passcommand = "cat ${config.age.secrets."bk-passwd".path}";

        hooks = {
          ntfy = {
            topic = "backups";
            username = "misc";
            password = "\${NTFY_PASSWORD}";
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
          before_backup = [ (pkgs.writeScript "home-backup-prepare.sh" ''
            if [ -e /mnt/btrfs-home-top-lvl/home-borgmatic-snapshot ]
            then
              ${pkgs.btrfs-progs}/bin/btrfs subvolume delete -c /mnt/btrfs-home-top-lvl/home-borgmatic-snapshot
            fi
            ${pkgs.btrfs-progs}/bin/btrfs subvolume snapshot -r /mnt/btrfs-home-top-lvl/home /mnt/btrfs-home-top-lvl/home-borgmatic-snapshot
            '')
          ];
          after_everything = [
            "${pkgs.btrfs-progs}/bin/btrfs subvolume delete /mnt/btrfs-home-top-lvl/home-borgmatic-snapshot"
          ];
        };
      };
    };
  };
}
