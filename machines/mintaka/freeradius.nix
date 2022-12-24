{ config, pkgs, lib, ... }: {
  services.freeradius.enable = true;
  services.freeradius.debug = true;

  users.users.radius.group = "radius";
  users.groups.radius = { };

  users.users.radius.isSystemUser = true;

}
