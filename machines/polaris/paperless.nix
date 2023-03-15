{ pkgs, lib, config, ... }:
{
  services.paperless = {
    enable = true;
    passwordFile = pkgs.writeText "password" "admin";
    extraConfig = {
      PAPERLESS_AUTO_LOGIN_USERNAME="admin";
      PAPERLESS_ADMIN_USER = "admin";
      PAPERLESS_CONSUMER_RECURSIVE = "true";
    };
  };
}
