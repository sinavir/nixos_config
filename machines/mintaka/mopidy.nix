{ pkgs, ... }:
{
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-local
      mopidy-mopify
      mopidy-youtube
      mopidy-musicbox-webclient
      mopidy-mpd
    ];
    configuration = ''
      [file]
      enabled = false
      
      [local]
      media_dir = /var/lib/mopidy/music

      [audio]
      output = pulsesink server=127.0.0.1

      [mopify]
      enabled = true
      debug = false
    '';
  };
}
