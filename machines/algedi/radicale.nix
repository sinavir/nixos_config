{ pkgs, config, lib, ... }:
{
  services.radicale = {
    enable = true;
    settings = {
      auth = {
        type = "htpasswd";
        htpasswd_filename = config.age.secrets."radicale-htpasswd".path;
        htpasswd_encryption = "bcrypt";
      };
    };
    rights = {
      root = {
        user = ".+";
        collection = "";
        permissions = "R";
      };
      principal = {
        user = ".+";
        collection = "{user}";
        permissions = "RW";
      };
      calendars = {
        user = ".+";
        collection = "{user}/[^/]+";
        permissions = "rw";
      };
      rentree = {
        user = ".*";
        collection = "rentree/[^/]+";
        permissions = "i";
      };
    };
  };
  services.nginx = {
    enable = true;
    virtualHosts."rz.sinavir.fr" = {
      forceSSL = true;
      enableACME = true;
      locations = {
        "/radicale/" = {
          proxyPass = "http://localhost:5232/";
          extraConfig = ''
            proxy_set_header  X-Script-Name /radicale;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header  Host $host;
            proxy_pass_header Authorization;
          '';
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}

