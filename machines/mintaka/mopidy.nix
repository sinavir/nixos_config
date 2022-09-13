{ pkgs, ... }:
{
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-iris
      mopidy-local
      mopidy-youtube
    ];
    configuration = ''
      [file]
      enabled = true
      media_dirs = /var/lib/mopidy/music|Music
      
      [local]
      media_dir = /var/lib/mopidy/music

      [audio]
      output = pulsesink server=127.0.0.1
    '';
  };
}
