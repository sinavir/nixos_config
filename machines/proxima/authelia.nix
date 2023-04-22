{ pkgs, lib, config, ... }:
  let name = "sinavir_sso";
authelia-snippets = pkgs.callPackage ../../pkgs/authelia-snippets {};
in
{
  services.authelia.instances.${name} = {
    enable = true;
    secrets = {
      jwtSecretFile = config.age.secrets."authelia_jwtSecret".path;
      storageEncryptionKeyFile = config.age.secrets."authelia_storageEncryptionKey".path;
    };
    environmentVariables = {
      AUTHELIA_NOTIFIER_SMTP_PASSWORD_FILE = config.age.secrets."authelia_smtp_password".path;
    };
    settings = {
      authentication_backend.file.path = "/var/lib/authelia-${name}/users.yaml";
      storage.local.path = "/var/lib/authelia-${name}/db.sqlite3";
      session.domain = "sinavir.fr";
      # TODO: Add systemd tmpfile rules
      notifier.smtp = {
        host = "mail.sinavir.fr";
        port = 465;
        username = "sso@sinavir.fr";
        sender = "sso@sinavir.fr";
      };
      server = {
        host = "127.0.0.1";
        port = 9990;
      };
      access_control.rules = [
        {
          domain = "rz.sinavir.fr";
          policy = "one_factor";
          subject = [ "group:radicale" ];
        }
      ];
    };
  };

  services.nginx.virtualHosts."auth.sinavir.fr" = {
    forceSSL = true;
    enableACME = true;

    locations."/" = {
      proxyPass = "http://127.0.0.1:9990";
      extraConfig = ''
        include ${authelia-snippets.proxy};
        '';
    };
    locations."/api/verify" = {
      proxyPass = "https://127.0.0.1:9990";
    };
  };
}
