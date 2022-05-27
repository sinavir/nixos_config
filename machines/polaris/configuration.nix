# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./hardware-configuration.nix
      ../../shared/users.nix
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

  networking.hostName = "polaris"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
  fonts.enableDefaultFonts = true;
  fonts.fonts = [
    pkgs.font-awesome
  ];

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    htop
  ];
  programs.vim.defaultEditor = true;
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  programs.ssh.startAgent = true;
  #programs.gnupg = {
  #  agent = {
  #    enable = true;
  #    pinentryFlavor = "curses";
  #  };
  #  package = pkgs.gnupg.override { pinentry = pkgs.pinentry; };
  #};
  hardware.opengl.enable = true;

  home-manager.users.maurice = import ./hm-maurice.nix;

  users.users.maurice = {
    extraGroups = [ "wireshark" "audio" "networkmanager" "video" ];
    hashedPassword = "$6$sKY5c.ui.GaeZNtP$TOCJXXdieguUTlYkktbvqZJbiZrx26OWb.M8bvlRYhjP/BFn9eZtqZdzUbICsT36mtgbN4GfGyAtu5FPo6DZm.";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

