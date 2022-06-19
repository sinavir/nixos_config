{ config, pkgs, lib, ... }:
{
  services.keycloak = {
    enable = true;
    database.passwordFile = "/var/lib/keycloak/pw"; #config.age.secrets."keycloakDBPassword".path;
    settings.hostname = "localhost";
  };
}
