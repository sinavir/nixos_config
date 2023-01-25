{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./mopidy.nix
    ../../shared/users.nix
    ./users.nix
    ../../shared/syncthing.nix
    ./secrets
    ../../shared/autoUpgrade.nix
    ./wireguard.nix
    ./nat.nix
    ./sound.nix
    #./crux.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = "mintaka"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true; #Internal
  networking.interfaces.enp3s2.useDHCP = true; #PCI normal (droite)
  networking.dhcpcd.extraConfig = ''
    # define static profile
    profile static_eth0
    static ip_address=129.199.244.6/23
    static routers=129.199.224.254
    static domain_name_servers=1.1.1.1

    # fallback to static profile on eth0
    interface enp3s2
    fallback static_eth0
  '';

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
  fonts.enableDefaultFonts = true;
  fonts.fonts = [ pkgs.font-awesome pkgs.helvetica-neue-lt-std pkgs.aegyptus ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    tmux
    git
    borgbackup
    htop
  ];
  programs.vim.defaultEditor = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  programs.ssh.startAgent = true;

  # Pour faire marcher sway
  hardware.opengl.enable = true;
  security.pam.services.swaylock = { };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?

}
