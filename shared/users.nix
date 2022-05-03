{ ... }: {
  users.groups.maurice.gid=1000;
  users.mutableUsers = false;
  users.users.maurice = {
    isNormalUser = true;
    group="maurice";
    uid=1000;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    home = "/home/maurice";
    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpwF+XD3HgX64kqD42pcEZRNYAWoO4YNiOm5KO4tH6o maurice@polaris"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1FilN5OcWKTulTGs8HA0fHZMW9vpnt5tSkH3N1fI7m u0_a208@localhost"
      ];
  };
}
