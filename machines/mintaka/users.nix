{ lib, ... }: {
  users.groups.maurice.gid = 1000;
  users.mutableUsers = false;
  users.users.maurice = {
    extraGroups = lib.mkForce [
      "audio"
      "video"
      "wheel"
      "pulse-access"
    ]; # Enable ‘sudo’ for the user.
    hashedPassword =
      "$6$0g0qYLeYeYt/.CCJ$ZCUiB/oV65XX1pu40.Ldq9zCxqIqeIInqZ2EcLES6AZ7bXQZvQAyBJ1gx7uMXgWjrB7JibO/uaYf.yOyKI0JS1";
  };
  users.users.borg = {
    isNormalUser = true;
    home = "/backups";
    createHome = true;
    openssh.authorizedKeys.keyFiles = [ ./../../shared/pubkeys/maurice.keys ];
  };
  imports = [ <home-manager/nixos> ];
  home-manager.users.maurice = import ./hm;
}
