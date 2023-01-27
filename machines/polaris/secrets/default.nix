{ pkgs, config, lib, ... }: {
  imports = [ <agenix/modules/age.nix> ];
  environment.systemPackages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> { })
  ];
  age.secrets."wg-polaris".file = ./wg-polaris.age;
  age.identityPaths = [ "/home/maurice/.ssh/id_ed25519" ];
}
