{ pkgs, config, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."photos.ernestophone.fr" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/lib/ernestophotos/public";
      locations = {
        "~ ^/(.*)$" = {
          extraConfig = ''
            try_files $uri /index.php?/$1 =404;
            fastcgi_pass unix:${config.services.phpfpm.pools."ernestophotos".socket};
            fastcgi_index index.php;
          '';
        };
      };
    };
  };
  services.phpfpm.pools."ernestophotos" = {
    user = config.services.nginx.user;
    group = config.services.nginx.group;
    phpPackage = pkgs.php81.withExtensions ({ enabled, all }:
      enabled ++ [ all.imagick all.bcmath all.mbstring all.gd]);
    settings = {
      "pm" = "dynamic";
      "pm.max_children" = 75;
      "pm.start_servers" = 10;
      "pm.min_spare_servers" = 5;
      "pm.max_spare_servers" = 20;
      "pm.max_requests" = 500;
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
