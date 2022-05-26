{ pkgs, ... }:
{
  imports = [
    <agenix/modules/age.nix>
  ];
  services.nginx = {
    enable = true;
    virtualHosts."sinavir.fr" = {
      forceSSL = true;
      enableACME = true;
      root = "/var/lib/sinavir.fr";
      locations = {
        "plans-ens" = {
          autoindex = true;
          basicAuthFile = age.secrets."plans-ens".path;
          extraConfig = "autoindex on;";
        };
      };
    };
  };
}
