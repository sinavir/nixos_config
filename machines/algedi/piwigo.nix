{ pkgs, config, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."photos.ernestophone.fr" = {
      forceSSL = true;
      enableACME = true;
      locations = {
        "~ ^/photos.+\\.php$" = {
          root = "/var/lib/piwigo";
          extraConfig = ''
            try_files $uri =404;
            fastcgi_pass unix:${config.services.phpfpm.pools."piwigo".socket};
          '';
        };
        "/photos" = {
          root = "/var/lib/piwigo";
        };
      };
    };
  };
  users.users.piwigo = {
    group = config.services.nginx.group;
    isSystemUser = true;
  };
  services.phpfpm.pools."piwigo" = {
    user = "piwigo";
    group = config.services.nginx.group;
    phpPackage = pkgs.php81.withExtensions ({ enabled, all }:
      enabled ++ [ all.imagick ]);
    settings = {
      "listen.owner" = "piwigo";
      "listen.group" = config.services.nginx.group;
      "pm" = "dynamic";
      "pm.max_children" = 75;
      "pm.start_servers" = 10;
      "pm.min_spare_servers" = 5;
      "pm.max_spare_servers" = 20;
      "pm.max_requests" = 500;
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.mysql = {
    enable = true;
    bind = "127.0.0.1";
    package = pkgs.mariadb;
  };
}
