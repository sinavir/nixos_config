# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../shared/users.nix
      ./wireguard.nix
      ./radicale.nix
      ./nginx.nix
      ./static-website.nix
      ./ernestophotos.nix
      ./ernestoredirection.nix
      ../../shared/secrets
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "algedi"; # Define your hostname.

  networking.useDHCP = false;
  networking.interfaces.ens18 = {
    useDHCP = true;
    ipv6 = {
      addresses = [{
        address = "2001:470:1f13:187:b256:8cb7:beb0:9d45";
        prefixLength = 64;
      }];
    };
    mtu = 1350;
  };
  networking.interfaces.wg0 = {
    mtu = 1270;
  };
  networking.interfaces.ens19.useDHCP = true;
  networking.interfaces.ens21 = {
    useDHCP = false;
    ipv4 = {
      addresses = [{
        address = "45.13.104.28";
        prefixLength = 32;
      }];
      routes = [{
        address = "0.0.0.0";
        prefixLength = 0;
      }];
    };
  };

  security.sudo.wheelNeedsPassword = false;



  # Set your time zone.
  time.timeZone = "Europe/Paris";


  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
  fonts.enableDefaultFonts = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    htop
  ];
  programs.vim.defaultEditor = true;
 
  security.acme = {
    defaults.email = "sinavir@sinavir.fr";
    acceptTerms = true;
  };    

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  programs.ssh.startAgent = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
