{ config, lib, pkgs, ... }:
let
  configFile = pkgs.writeTextFile "config.php" ''
    define('DATA_DIR', '${config.services.kanboard.dataDir}');
    define('MAIL_FROM', '${config.services.kanboard.mailFrom}');
    define('ENABLE_URL_REWRITE', ${config.services.kanboard.enableUrlRewrite});

    ${config.services.kanboard.extraConfig}

  '';
in
{
  options.services.kanboard = {
    pkg = lib.mkOption {
      type = lib.types.path;
      default = import ./kanboard-pkg.nix { inherit pkgs; config = configFile; };
      description = "The kanboard package to use";
    };
    enable = lib.mkEnableOption "kanboard";
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = /var/lib/kanboard/data;
      description = "Data folder (must be writeable by the web server user and absolute)";
    };
    enableUrlRewrite = lib.mkEnableOption "url rewrite";
    mailFrom = lib.mkOption {
      type = lib.types.str;
      description = "E-mail address used for the \"From\" header (notifications)";
    };
    extraConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    host = lib.mkOption {
      type = lib.types.str;
      description = "Hostname of nginx virualHost";
    };
  };
  config = {
    services.nginx.enable = true;
    services.nginx.virtualHosts.${config.services.kanboard.host} = {
      root = config.services.kanboard.pkg + "/share/kanboard/app";
      index = "index.php";
      locations = {
        "/" = {
          try_files = "$uri $uri/ /index.php$is_args$args";
        };
        "~ \.php" = {
          try_files = "$uri =404";
        };
        "~ /(?:config.php|\.ht)" = {
          extraConfig = "deny all";
        };
      };
    };
  };
}
