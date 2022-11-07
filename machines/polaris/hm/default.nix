{ config, pkgs, lib, ... }:
let
  website = pkgs.writeShellScriptBin "website"
    ''
    dir=$(dirname $1)
    file=$(basename $1)
    rnd=$(xxd -p -l 16 /dev/random)
    
    ssh sinavir.fr "cat > site/$dir/$rnd-$file"
    echo "https://sinavir.fr/$dir/$rnd-$file"
    '';
in
{
  imports = [
    ./ssh-config.nix
    ./git.nix
    ./swayidle.nix
    ./sway.nix
    ./discord.nix
  ];
  nixpkgs.config.allowUnfree = true;
  services = {
    gpg-agent.enable = true;
    gpg-agent.pinentryFlavor = "tty";
    
  };
  programs = {
    password-store = {
      enable = true;
    };
    gpg = {
      enable = true;
      package = pkgs.gnupg.override { pinentry = pkgs.pinentry; };
    };
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-addon-nix
        vim-go
        rust-vim
        vim-airline
        vim-airline-themes
        ultisnips
        vimtex
        vim-fugitive
        base16-vim
        vim-wayland-clipboard
        vim-svelte
        (pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-lark-syntax";
          version = "2020-09-18";
          src = pkgs.fetchFromGitHub {
            owner = "lark-parser";
            repo = "vim-lark-syntax";
            rev = "80891559f5686b5d2a897cc25628fdf5a2d0aff0";
            sha256 = "sha256-FlgguTfMbhh4q1f+eVnb+Q9OmlSM+w148ZJp4t6zdYo=";
          };
        })
      ];
      settings = {
        number = true;
      };
      extraConfig = ''
        set termguicolors
        colorscheme base16-bright
        let g:airline_theme='base16_bright'

        set noesckeys
        set incsearch

        set mouse=""

        let g:vimtex_view_method = 'zathura'
      '';
    };
    zathura.enable=true;
    kitty = {
      enable=true;
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
    xournalpp
    freecad
    (python39.withPackages (ps: [
      ps.numpy
      ps.scipy
      ps.matplotlib
    ]))
    signal-desktop
    firefox-wayland
    musescore
    thunderbird
    wl-clipboard
    xorg.xeyes
    texlive.combined.scheme-full
    mpv
    pulsemixer
    discord
    xdg-utils
    mako
    keepassxc
    website
    gnome3.adwaita-icon-theme
    krita
    inkscape
    virt-manager
    notion-app-enhanced
    vlc
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    TERM = "xterm-256color";
  };
  xdg.enable = true;
  home.file = let
      nicetabs = pkgs.writeText "nicetabs.vim" ''
        setlocal expandtab
        setlocal shiftwidth=2
        setlocal softtabstop=2
        '';
  in {
    ".vim/UltiSnips/".source = pkgs.fetchFromGitHub {
      owner = "sinavir";
      repo = "ultisnip-snippets";
      rev = "09b4d4a720cb780a156fd487188bf192b58aa174";
      sha256 = "0l39gf0aivdbsqr3dqqa4mql8kkypggy3z0bgpzr96z17b6ylwj4";
    };
    ".config/swaylock/config".source = pkgs.substituteAll { src = ./swaylockConfig; photo = ./menou1.JPG; };
    ".vim/after/ftplugin/javascript.vim".source = nicetabs;
    ".vim/after/ftplugin/html.vim".source = nicetabs;
    ".vim/after/ftplugin/svelte.vim".source = nicetabs;
  };
}
