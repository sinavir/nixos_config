{ pkgs, config }:
pkgs.kanboard.overrideAttrs (old: {
  installPhase = (old.installPhase or "") + ''
    ln -s ${config} $out/share/kanboard/config.php
  '';
})
