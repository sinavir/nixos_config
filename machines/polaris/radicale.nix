{ pkgs, config, lib, ... }:
{
  services.radicale = {
    enable = true;
    settings = {
      auth = {
        type = "htpasswd";
        htpasswd_filename = builtins.toString ./radicale_passwd;
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
}

