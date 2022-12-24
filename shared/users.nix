{ ... }: {
  users.groups.maurice.gid = 1000;
  users.mutableUsers = false;
  users.users.maurice = {
    isNormalUser = true;
    group = "maurice";
    uid = 1000;
    extraGroups =
      [ "libvirtd" "wheel" "audio" "video" ]; # Enable ‘sudo’ for the user.
    home = "/home/maurice";
    openssh.authorizedKeys.keyFiles = [ ./pubkeys/maurice.keys ];
  };
}
