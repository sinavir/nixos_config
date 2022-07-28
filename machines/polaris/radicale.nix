{ pkgs, config, lib, ... }:
{
  services.radicale = {
    enable = true;
    settings = {
      auth = {
        type = "htpasswd";
        htpasswd_filename = ./radicale_passwd;
        htpasswd_encryption = "bcrypt";
      };
    };
    rights = {
      rentree = {
        user = ".*";
        collection = "rentree";
        permissions = "i";
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
    };
  };
}

