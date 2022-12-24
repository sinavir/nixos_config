{ config, lib, pkgs, ... }:
let myPkgs = import ../../pkgs { inherit pkgs; };
in {
  systemd.services.crux = {
    after = [ "network.target" ];
    description = "A bot for hackens";
    script = "${myPkgs.crux}/bin/crux";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 1;
    };
  };
}
