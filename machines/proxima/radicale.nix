{
  pkgs,
  config,
  lib,
  ...
}: let
  authelia-snippets = pkgs.callPackage ../../pkgs/authelia-snippets {};
in {
  services.radicale = {
    enable = true;
    settings = {
      auth = {
        type = "http_x_remote_user";
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
      common = {
        user = ".*";
        collection = "common/[^/]+";
        permissions = "rw";
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
            include ${authelia-snippets.authrequest-basic};
            proxy_set_header  X-Script-Name /radicale;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header  X-Remote-User $user;
            proxy_set_header  Host $host;
            proxy_pass_header Authorization;
          '';
        };
      };
      extraConfig = ''
        set $upstream_authelia http://127.0.0.1:9990;
        include ${authelia-snippets.location-basic};
      '';
    };
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
