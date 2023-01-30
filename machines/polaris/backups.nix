{ config, pkgs, lib, ... }:
{
  services.btrbk = {
    instances = {
      btrbk = {
        onCalendar = "*-*-* *:00/15:00";
        settings = {
          snapshot_preserve_min = "2h";
          volume."/mnt/btrfs-top-lvl" = {
            subvolume = "home";
            snapshot_dir = "btrbk_snapshots";
          };
        };
      };
    };
  };
}
