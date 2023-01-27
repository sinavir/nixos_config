{ config, pkgs, lib, ... }:
let
  website = pkgs.writeShellScriptBin "website" ''
    dir=$(dirname $1)
    file=$(basename $1)
    rnd=$(xxd -p -l 16 /dev/random)

    ssh sinavir.fr "cat > site/$dir/$rnd-$file"
    echo "https://sinavir.fr/$dir/$rnd-$file"
  '';
  ms4-nixshell = pkgs.writeShellScriptBin "ms4" ''
    ${pkgs.ms4}/bin/mscore $@
  '';
in
{
  imports =
    [ ./vim.nix ./ssh-config.nix ./sway/swayidle.nix ./sway ];
  services = {
    gpg-agent.enable = true;
    gpg-agent.pinentryFlavor = "tty";

  };
  programs = {
    gpg = {
      enable = true;
      package = pkgs.gnupg.override { pinentry = pkgs.pinentry; };
    };
    zathura.enable = true;
    kitty = {
      enable = true;
      extraConfig = "enable_audio_bell no";
    };
    bash = {
      enable = true;
      shellAliases = {
        s = "kitty +kitten ssh";
        zat = "zathura";
        nsp = "nix-shell -p";
      };
      profileExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec sway
        fi
      '';
    };
  };

  home.packages = with pkgs; [
    imv
    libreoffice
    xournalpp
    freecad
    (python39.withPackages (ps: [ ps.numpy ps.scipy ps.matplotlib ]))
    signal-desktop
    firefox-wayland
    musescore
    ms4-nixshell
    thunderbird
    wl-clipboard
    xorg.xeyes
    texlive.combined.scheme-full
    mpv
    pulsemixer
    discord
    xdg-utils
    mako
    website
    gnome3.adwaita-icon-theme
    krita
    inkscape
    virt-manager
    vlc
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    TERM = "xterm-256color";
  };
  xdg.enable = true;

  home.stateVersion = "22.11";

}
