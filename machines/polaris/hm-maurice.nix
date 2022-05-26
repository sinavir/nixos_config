{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  services = {
    gpg-agent.enable = true;
    gpg-agent.pinentryFlavor = "tty";
  };
  programs = {
    password-store = {
      enable = true;
    };
    gpg.enable = true;
    git = {
      enable = true;
      userName  = "sinavir";
      userEmail = "maurice.debray@ens.psl.eu";
      aliases = {
        co = "checkout";
        ci = "commit";
        br = "branch --all -v";
        st = "status";
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all";
      };
    };
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-addon-nix
        vim-airline
        vim-airline-themes
        ultisnips
        vimtex
        vim-fugitive
        base16-vim
      ];
      settings = {
        number = true;
      };
      extraConfig = ''
        set mouse=""

        " set termguicolors
        " colorscheme base16-atelier-seaside
        " let g:airline_theme='base16_atelier_seaside'

        set noesckeys
        set incsearch
      '';
    };
    zathura.enable=true;
    alacritty = {
      enable=true;
    };
    bash = {
      enable = true;
      shellAliases = {
        ll = "ls -larth";
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true ;
    config = {
      # assigns = {};

      input = {
        "type:keyboard" = { xkb_layout = "fr"; };
        "type:touchpad" = { tap = "enabled"; };
      };
      # Quel magnifique font d'écran
      output = { "*" = { bg = "${./menou1.JPG} fill"; }; };
      menu = "wofi --show run";
      modifier = "Mod4";
      terminal = "alacritty";
    };
  };
  home.packages = with pkgs; [
    firefox-wayland
    musescore
    thunderbird
    wl-clipboard
    wofi
    xorg.xeyes
    texlive.combined.scheme-full
    mpv
    pulsemixer
    discord
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CUREENT_DESKTOP = "sway";
  };
  home.file = {
    ".vim/UltiSnips/".source = pkgs.fetchFromGitHub {
      owner = "sinavir";
      repo = "ultisnip-snippets";
      rev = "09b4d4a720cb780a156fd487188bf192b58aa174";
      sha256 = "0l39gf0aivdbsqr3dqqa4mql8kkypggy3z0bgpzr96z17b6ylwj4";
    };
  };
}
