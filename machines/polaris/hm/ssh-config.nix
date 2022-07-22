{ ... }:
{
  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "proxima" = {
      hostname = "sinavir.fr";
      forwardAgent = true;
    };
    "algedi" = {
      hostname = "rz.sinavir.fr";
      proxyJump = "sinavir.fr";
      forwardAgent = true;
    };
    "mintaka" = {
      hostname = "thurne.sinavir.fr";
      proxyJump = "mdebray@sas.eleves.ens.fr";
      forwardAgent = true;
    };
    "sas" = {
      hostname = "mdebray@sas.eleves.ens.fr";
    };
    "git.rz.ens.wtf" = {
      addressFamily = "inet";
    };
  };
}
