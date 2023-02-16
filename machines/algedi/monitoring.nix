{ lib, pkgs, config, ... }:
{
  services.netdata = {
    enable = true;
  };
}
