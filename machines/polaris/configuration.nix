{ config, pkgs, ... }:

{
  imports = [
    # TODO add backups
    <home-manager/nixos>
    ../../shared
    ./bootloader.nix
    ./chaise-clavier.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./secrets
    ./sound.nix
    ./ssh.nix
    ./syncthing.nix
    ./user.nix
    ./virt-manager.nix
  ];

  nixosIsUnstable = false;

  time.timeZone = "Europe/Paris";

  # Home-manager
  home-manager.users.maurice = import ./hm;
  home-manager.useGlobalPkgs = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
