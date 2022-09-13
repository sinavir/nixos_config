{ pkgs, ... }:
{
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-iris
      mopidy-local
    ];
    configuration = ''
      [file]
      enabled = true
      media_dirs = /var/lib/mopidy/music|Music
    '';
  };
}
