{ pkgs, lib, config, ... }:
{
  services.netdata = {
    enable = true;
  };
}
