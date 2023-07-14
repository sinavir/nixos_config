{...}: {
  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "proxima" = {
      user = "root";
      hostname = "sinavir.fr";
    };
    "schedar" = {
      user = "root";
      hostname = "51.15.171.220";
    };
    "capella" = {
      user = "root";
      hostname = "capella.internal.sinavir.fr";
    };
    "rigel" = {
      user = "root";
      hostname = "rigel.sinavir.fr";
    };
    "sas" = {
      user = "mdebray";
      hostname = "sas.eleves.ens.fr";
    };
  };
}
