{ pkgs, config, lib, ... }: {
  imports = [ <agenix/modules/age.nix> ];
  environment.systemPackages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> { })
  ];
  age.secrets = {
    "vpn_preauth" = {
      file = ./vpn_preauth.age;
    };
  };
}
