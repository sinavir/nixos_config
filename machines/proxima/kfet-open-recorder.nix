{ pkgs, config, lib, ... }:
let ws-scraper = import ./ws-scraper { inherit pkgs; };
in
{
  systemd.services.kfet-open-recorder = {
    script = ''
      ${ws-scraper}/bin/ws-scrapper \
        wss://cof.ens.fr/ws/k-fet/open \
        $STATE_DIRECTORY/kfet-open-recorder/db.sqlite
      '';
    serviceConfig = {
      DynamicUser = true;
      StateDirectory = "kfet-open-recorder";
    };
  };
}
    

