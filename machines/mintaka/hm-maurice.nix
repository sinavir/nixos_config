{ pkgs, lib, ... }:
{
  services = {
    gpg-agent.enable = true;
  };
  programs = {
    password-store = {
      enable = true;
    };
    gpg.enable = true;
    git = {
      enable = true;
      userName  = "sinavir";
      userEmail = "sinavir@sinavir.fr";
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
    bash.enable = true;
  };

  home.packages = with pkgs; [
    screen
    texlive.combined.scheme-full
    mpv
    pulsemixer
  ];
  home.file = {
    ".vim/UltiSnips/".source = pkgs.fetchFromGitHub {
      owner = "sinavir";
      repo = "ultisnip-snippets";
      rev = "09b4d4a720cb780a156fd487188bf192b58aa174";
      sha256 = "0l39gf0aivdbsqr3dqqa4mql8kkypggy3z0bgpzr96z17b6ylwj4";
    };
  };
}
