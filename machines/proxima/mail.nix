{ config, pkgs, ... }:
{
  imports = [
    (builtins.fetchTarball {
      # Pick a commit from the branch you are interested in
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/f535d8123c4761b2ed8138f3d202ea710a334a1d/nixos-mailserver-f535d8123c4761b2ed8138f3d202ea710a334a1d.tar.gz";
      # And set its hash
      sha256 = "0csx2i8p7gbis0n5aqpm57z5f9cd8n9yabq04bg1h4mkfcf7mpl6";
    })
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.sinavir.fr";
    domains = [ "sinavir.fr" ];

    # A list of all login accounts. To create the password hashes, use
    # nix run nixpkgs.apacheHttpd -c htpasswd -nbB "" "super secret password" | cut -d: -f2
    loginAccounts = {
      "sinavir@sinavir.fr" = {
         hashedPasswordFile = "/var/lib/mail/sinavir";
         aliases = [
           "maurice@sinavir.fr"
           "contact@sinavir.fr"
           "@sinavir.fr"
         ];
         catchAll = [
           "sinavir.fr"
         ];
         quota="5G";
       };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = 3;
  };
  services.roundcube = {
     enable = true;
     hostName = "mail.sinavir.fr";
     extraConfig = ''
       # starttls needed for authentication, so the fqdn required to match
       # the certificate
       $config['smtp_server'] = "tls://${config.mailserver.fqdn}";
       $config['smtp_user'] = "%u";
       $config['smtp_pass'] = "%p";
     '';
  };

  services.nginx.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
