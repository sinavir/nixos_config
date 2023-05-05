{ pkgs, lib, config, ... }:
{
  services.paperless = {
    enable = true;
    passwordFile = pkgs.writeText "password" "admin";
    extraConfig = {
      PAPERLESS_ADMIN_USER = "admin";
      PAPERLESS_CONSUMER_RECURSIVE = "true";
    };
  };
}
