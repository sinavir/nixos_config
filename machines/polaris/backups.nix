{ config, pkgs, lib, ... }:
{
  services.btrbk = {
    instances = {
      btrbk = {
        onCalendar = "*-*-* *:00/2:00";
        settings = {
          snapshot_preserve_min = "1d";
          volume."/mnt/btrfs-home-top-lvl" = {
            subvolume = "home";
            snapshot_dir = "btrbk_snapshots";
          };
        };
      };
    };
  };
}
