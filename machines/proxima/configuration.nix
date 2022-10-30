# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../shared/users.nix
      ./thelounge.nix
      #./zerobin.nix
      ./mail.nix
      ./cal-ens.nix
      ./kfet-proxy.nix 
      ./static-website.nix
      ./nginx.nix
      #./piwigo.nix
      ./wireguard.nix
      ./secrets
      ./kfet-open-recorder.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sdb"; # or "nodev" for efi only

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "proxima"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens3 = {
    useDHCP = true;
    ipv6.addresses = [{
      address = "2001:41d0:404:200::81a1";
      prefixLength = 128;
    }];
  };
  networking.defaultGateway6 = {
    address = "2001:41d0:404:200::1";
    interface = "ens3";
  };

  boot.kernel.sysctl = {
    "net.ipv4.conf.wg0.forwarding" = true;
  };

  security.acme = {
    defaults.email = "sinavir@sinavir.fr";
    acceptTerms = true;
  };      

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
    screen
    htop
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];
  programs.vim.defaultEditor = true;

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
