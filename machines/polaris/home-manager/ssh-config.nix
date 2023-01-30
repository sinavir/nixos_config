{ ... }: {
  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "proxima" = {
      user = "root";
      hostname = "sinavir.fr";
    };
    "algedi" = {
      user = "root";
      hostname = "algedi.sinavir.fr";
    };
    "mintaka" = {
      user = "root";
      hostname = "mintaka.sinavir.fr";
      proxyJump = "mdebray@sas.eleves.ens.fr";
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
