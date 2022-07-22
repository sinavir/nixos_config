# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./hardware-configuration.nix
      ./syncthing.nix
      ./virt-manager.nix
      ./networking.nix
      ./sound.nix
      ./user.nix
      ../../shared/users.nix
      ../../shared/syncthing.nix
      ../../shared/secrets
      ./wireguard.nix
      ./kfet-open.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Amsterdam";

  age.identityPaths = [ "/home/maurice/.ssh/id_ed25519" ];
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
  fonts.enableDefaultFonts = true;
  fonts.fonts = [
    pkgs.font-awesome
    pkgs.helvetica-neue-lt-std
  ];

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    htop
    unzip
    traceroute
    dig
  ];

  programs.vim.defaultEditor = true;
  programs.ssh.startAgent = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  security.pam.services.swaylock = {};
  hardware.opengl.enable = true;

  home-manager.users.maurice = import ./hm;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
