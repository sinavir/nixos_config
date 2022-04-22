{ pkgs, lib, ... }:
{
  services = {
    gpg-agent.enable = true;
    gpg-agent.pinentryFlavor = "tty";
  };
  programs = {
    irssi = {
      enable = true;
      networks = {
        ulminfo = {
          nick = "maurice";
          server = {
            address= "ulminfo.fr";
            port=3725;
            ssl.enable = true;
          };
        };
      };
    };
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
    config = let modifier = "Mod4"; in {
      # On veut un clavier français
      input = { "type:keyboard" = { xkb_layout = "fr"; }; };
      # Quel magnifique font d'écran
      output = { "*" = { bg = "${./menou1.JPG} fill"; }; };
      menu = "wofi --show run";
      modifier = modifier;
      terminal = "alacritty";
      keybindings = lib.mkOptionDefault {
          "${modifier}+Ctrl+1" = "move container to workspace number 1";
          "${modifier}+Ctrl+2" = "move container to workspace number 2";
          "${modifier}+Ctrl+3" = "move container to workspace number 3";
          "${modifier}+Ctrl+4" = "move container to workspace number 4";
          "${modifier}+Ctrl+5" = "move container to workspace number 5";
          "${modifier}+Ctrl+6" = "move container to workspace number 6";
          "${modifier}+Ctrl+7" = "move container to workspace number 7";
          "${modifier}+Ctrl+8" = "move container to workspace number 8";
          "${modifier}+Ctrl+9" = "move container to workspace number 9";
          "${modifier}+Shift+z" = "move scratchpad";
          "${modifier}+z" = "scratchpad show";
        };
    };
  };
  home.packages = with pkgs; [
    firefox-wayland
    wl-clipboard
    wofi
    xorg.xeyes
    screen
    texlive.combined.scheme-full
    mpv
    pulsemixer
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
