{ lib, ... }: {
  users.groups.maurice.gid=1000;
  users.mutableUsers = false;
  users.users.maurice = {
    extraGroups = lib.mkForce [ "audio" "video" "wheel" "pulse-access" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$D6yIxKZ1GM37vKGh$On0hJnxptVpUePDqP20.fG5GmWWGTObqrhOu7Caxz5WTqnCmS8rXx0r02k/G6/0.9ciso.BTN4/bkEWDYOvRS/";
  };
  #imports = [ <home-manager/nixos> ];
  #home-manager.users.maurice = import ./hm-maurice.nix;
}
