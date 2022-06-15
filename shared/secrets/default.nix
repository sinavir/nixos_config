{ pkgs, ... }:
{
  imports = [
    <agenix/modules/age.nix>
  ];
  environment.systemPackages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];

  age.secrets."wg-polaris".file = ./wg-polaris.age;
  age.secrets."wg-algedi".file = ./wg-algedi.age;
}
