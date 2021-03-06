{ config, pkgs, ... }:
{
  imports = [
    (builtins.fetchTarball {
      # Pick a commit from the branch you are interested in
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/6e3a7b2ea6f0d68b82027b988aa25d3423787303/nixos-mailserver-6e3a7b2ea6f0d68b82027b988aa25d3423787303.tar.gz";
      # And set its hash
      sha256 = "1i56llz037x416bw698v8j6arvv622qc0vsycd20lx3yx8n77n44";
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
