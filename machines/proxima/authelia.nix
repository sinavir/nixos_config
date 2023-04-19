{ pkgs, lib, config, ... }:
{
  services.authelia.instances."sinavir_sso" = {
    enable = true;
    secrets = {
      jwtSecretFile = config.age.secrets."authelia_jwtSecret".path;
      storageEncryptionKeyFile = config.age.secrets."authelia_storageEncryptionKey".path;
    };
    environmentVariables = {
      AUTHELIA_NOTIFIER_SMTP_PASSWORD_FILE = config.age.secrets."authelia_smtp_password".path;
    };
    settings = {
      authentication_backend.file.path = "/var/lib/authelia/users.yaml";
      storage.local.path = "/var/lib/authelia/db.sqlite3";
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
          domain = "*.sinavir.fr";
          policy = "one_factor";
        }
      ];
    };
  };

  services.nginx.virtualHosts."auth.sinavir.fr" = {
    forceSSL = true;
    enableACME = true;

    location."/" = {
      proxyPass = "http://127.0.0.1:9990";
      extraConfig = ''
        ## Headers
        proxy_set_header Host $host;
        proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_set_header X-Forwarded-Uri $request_uri;
        proxy_set_header X-Forwarded-Ssl on;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Connection "";

        ## Basic Proxy Configuration
        client_body_buffer_size 128k;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503; ## Timeout if the real server is dead.
        proxy_redirect  http://  $scheme://;
        proxy_http_version 1.1;
        proxy_cache_bypass $cookie_session;
        proxy_no_cache $cookie_session;
        proxy_buffers 64 256k;

        ## Advanced Proxy Configuration
        send_timeout 5m;
        proxy_read_timeout 360;
        proxy_send_timeout 360;
        proxy_connect_timeout 360;
        '';
    };
    location."/api/verify" = {
      proxyPass = "https://127.0.0.1:9990";
    };
  };
}
