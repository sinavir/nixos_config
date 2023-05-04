{ config, pkgs, lib, ... }:
let
  website = pkgs.writeShellScriptBin "website" ''
    dir=$(dirname $1)
    file=$(basename $1)
    rnd=$(xxd -p -l 16 /dev/random)

    ssh sinavir.fr "cat > site/$dir/$rnd-$file"
    echo "https://sinavir.fr/$dir/$rnd-$file"
  '';
in
{
  imports =
    [ ./vim.nix ./ssh-config.nix ./sway/swayidle.nix ./sway ];
  services = {
    gpg-agent.enable = true;
    gpg-agent.pinentryFlavor = "tty";
    kdeconnect = {
      enable = true;
    };

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
    (python3.withPackages (ps: [ ps.black ps.isort ps.pylint ps.numpy ps.scipy ps.matplotlib ]))
    nodePackages.pyright
    discord
    firefox-wayland
    anki
    freecad
    gnome3.adwaita-icon-theme
    imv
    inkscape
    krita
    libreoffice
    mako
    mpv
    musescore
    pavucontrol
    pulsemixer
    signal-desktop
    texlive.combined.scheme-full
    thunderbird
    ungoogled-chromium
    virt-manager
    vlc
    website
    wl-clipboard
    xdg-utils
    xournalpp
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    TERM = "xterm-256color";
  };
  xdg.enable = true;

  home.stateVersion = "22.11";

}
