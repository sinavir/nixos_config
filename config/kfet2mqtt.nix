{ pkgs, ... }:
let
  python = pkgs.python39.withPackages (ps: [
    ps.asyncio-mqtt
    ps.websockets
  ]);
  script = pkgs.fetchgit {
    url = "https://git.eleves.ens.fr/hackens/kfet2mqtt.git";
    rev = "982d443933f8f38a0dac27e8f37d24c3fb5c1f26";
    sha256 = "0f2lhjph8mzliqvnxjbigd0l06mpbjynfb8jpp9zbavihkiilq61";
  };
in
{
  systemd.services."kfet2mqtt" = {
    enable = true;
    description = "Programme qui indique l'ouverture de la k-fet sur le broker mqtt d'hackENS";
    after = [ "network.target" ];
    #preStart = "while ! ${pkgs.ping} -c 1 -W 2 -q new.hackens.org; do sleep 1; done";
    serviceConfig = {
      ExecStart = "${python}/bin/python ${script}/script.py";
      Restart = "always";
    };
    wantedBy = [ "mulit-user.target" ];
  };
}
