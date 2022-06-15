{ pkgs, ... }:
{
  #age.secrets."plans-ens".file = ./plans-ens.age
  imports = [
    <agenix/modules/age.nix>
  ];
  environment.systemPackages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];
}
