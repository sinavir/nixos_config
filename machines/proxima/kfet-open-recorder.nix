{ pkgs, config, lib, ... }:
let ws-scraper = import ./ws-scraper { inherit pkgs; };
in
{
  systemd.services.kfet-open-recorder = {
    script = ''
      ${ws-scraper}/bin/ws-scraper \
        wss://cof.ens.fr/ws/k-fet/open \
        $STATE_DIRECTORY/db.sqlite
      '';
    serviceConfig = {
      DynamicUser = true;
      StateDirectory = "kfet-open-recorder";
    };
  };
}
    

