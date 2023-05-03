{ pkgs, config, lib, ... }: {
  imports = [ <agenix/modules/age.nix> ];
  environment.systemPackages =
    [ (pkgs.callPackage <agenix/pkgs/agenix.nix> { }) ];

  age.secrets = {
    "wg-proxima" = {
      file = ./wg-proxima.age;
      group = "systemd-network";
      mode = "0440";
    };
    "plansPasswd" = {
      file = ./plans-passwd.age;
      owner = "nginx";
      group = "nginx";
    };
    "vaultwarden.env" = {
      file = ./vaultwarden.age;
      owner = "vaultwarden";
      group = "vaultwarden";
    };
    "vaultMailPass" = {
      file = ./vaultMailPass.age;
      owner = "dovecot2";
      group = "dovecot2";
    };
    "ssoMailPass" = {
      file = ./ssoMailPass.age;
      owner = "dovecot2";
      group = "dovecot2";
    };
    "radicale" = {
      file = ./radicale.age;
      owner = "radicale";
      group = "radicale";
    };
    "authelia_jwtSecret" = {
      file = ./authelia_jwtSecret.age;
      owner = "authelia-sinavir_sso";
      group = "authelia-sinavir_sso";
    };
    "authelia_storageEncryptionKey" = {
      file = ./authelia_storageEncryptionKey.age;
      owner = "authelia-sinavir_sso";
      group = "authelia-sinavir_sso";
    };
    "authelia_smtp_password" = {
      file = ./authelia_smtp_password.age;
    };
    "oidc_headscale_secret" = {
      file = ./oidc_headscale_secret.age;
      owner = "headscale";
      group = "headscale";
    };
    "oidc_headscale_authelia_secret" = {
      file = ./oidc_headscale_secret.age;
      owner = "authelia-sinavir_sso";
      group = "authelia-sinavir_sso";
    };
  };
}
