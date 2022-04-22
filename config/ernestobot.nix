{ ... }:
{
  systemd.units.ernestobot = {
    ExecStart = pkgs.fetchGit {
      blabla
    }

  };
}
