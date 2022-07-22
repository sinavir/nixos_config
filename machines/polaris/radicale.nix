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
      storage.hook = "git add -A && (git diff --cached --quiet || git commit -m \"Changes by %(user)\" )";
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
      root = {
        user = "root";
        collection = ".*";
        permissions = "RrWw";
      };
    };
  };
}

