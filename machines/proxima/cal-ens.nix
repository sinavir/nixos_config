{ ... }:
let
  mkCloudLocation = { from, cloudHost }: {
    name = "/cal/${from}";
    value = {
      extraConfig = ''
        proxy_pass https://${cloudHost}/remote.php/dav/public-calendars/;
        proxy_set_header Host ${cloudHost};
      '';
    };
  };
  clouds = [
    { from = "klub-reseau"; cloudHost = "nuage.beta.rz.ens.wtf"; }
    { from = "eleves-ens"; cloudHost = "cloud.eleves.ens.fr"; }
    { from = "frama-agenda"; cloudHost = "framagenda.org"; }
  ];
in
{
  services.nginx = {
    enable = true;

    resolver = { 
      addresses = [ "1.1.1.1" ];
    };

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "cal.sinavir.fr" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/lib/cal.sinavir.fr";
        locations = (builtins.listToAttrs (map mkCloudLocation clouds)) // {
          "/cal/rentree".extraConfig = ''
              proxy_pass https://rz.sinavir.fr/radicale/rentree;
              proxy_set_header Host rz.sinavir.fr;
            '';
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
