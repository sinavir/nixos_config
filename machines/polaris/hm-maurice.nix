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

        set termguicolors
        colorscheme base16-bright
        let g:airline_theme='base16_bright'

        set noesckeys
        set incsearch
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
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true ;
    config = let
        fontsize = 9.0;
        themeColors = import ./base16-bright.nix;
      in
      {
      # assigns = {};

      fonts = {
        names = [ "monospace" "FontAwesome5Free" ];
        size = fontsize;
      };
      focus.followMouse = "no";
      # gaps
      input = {
        "*" = { xkb_numlock = "enable"; };
        "type:keyboard" = { xkb_layout = "fr"; };
        "type:touchpad" = { tap = "enabled"; };
      };
      
      keybindings = let 
        mod = config.wayland.windowManager.sway.config.modifier;
        menu = config.wayland.windowManager.sway.config.menu;
        term = config.wayland.windowManager.sway.config.terminal;
      in {
        "${mod}+Return" = "exec ${term}";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec ${menu}";
        "${mod}+a" = "exec firefox";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+e" = "swaymsg exit";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+ampersand" = "workspace 1";
        "${mod}+eacute" = "workspace 2";
        "${mod}+quotedbl" = "workspace 3";
        "${mod}+apostrophe" = "workspace 4";
        "${mod}+parenleft" = "workspace 5";
        "${mod}+minus" = "workspace 6";
        "${mod}+egrave" = "workspace 7";
        "${mod}+underscore" = "workspace 8";
        "${mod}+ccedilla" = "workspace 9";
        "${mod}+agrave" = "workspace 10";

        "${mod}+Shift+ampersand" = "move container to workspace 1";
        "${mod}+Shift+eacute" = "move container to workspace 2";
        "${mod}+Shift+quotedbl" = "move container to workspace 3";
        "${mod}+Shift+apostrophe" = "move container to workspace 4";
        "${mod}+Shift+parenleft" = "move container to workspace 5";
        "${mod}+Shift+minus" = "move container to workspace 6";
        "${mod}+Shift+egrave" = "move container to workspace 7";
        "${mod}+Shift+underscore" = "move container to workspace 8";
        "${mod}+Shift+ccedilla" = "move container to workspace 9";
        "${mod}+Shift+agrave" = "move container to workspace 10";

        "${mod}+b" = "splith";
        "${mod}+v" = "splitv";

        "${mod}+s" = "layout stacking";
        "${mod}+z" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        "${mod}+f" = "fullscreen";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        "${mod}+w" = "focus parent";
        "${mod}+Shift+w" = "focus child";

        "${mod}+Shift+m" = "move scratchpad";
        "${mod}+m" = "scratchpad show";

        "${mod}+i" = "exec swaylock";
        "${mod}+shift+i" = "exec systemctl suspend";
        "${mod}+t" = "border toggle";
        "${mod}+r" = "mode \"resize\"";

        "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | wl-copy";

        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";

        #"XF86AudioPlay" = "exec playerctl play-pause";
        #"XF86AudioNext" = "exec playerctl next";
        #"XF86AudioPrev" = "exec playerctl previous";
        "XF86RFKill" = "exec ${term} -e nmtui";
        "XF86Search" = "exec ${pkgs.xdg-utils}/bin/xdg-open https://search.nixos.org";
      };
        

      # Quel magnifique font d'écran
      menu = "${pkgs.wofi}/bin/wofi -i --show run";
      modifier = "Mod4";
      output = { "*" = { bg = "${./menou1.JPG} fill"; }; };
      terminal = "kitty";
      bars = [{
        position = "top";
        fonts = {
          names = [ "monospace" "FontAwesome5Free" ];
          size = fontsize;
        };
        colors = {
          background = "${themeColors.base00}";
          separator =  "${themeColors.base01}";
          statusline = "${themeColors.base04}";
          focusedWorkspace =   { border = "${themeColors.base0A}"; background = "${themeColors.base0A}"; text = "${themeColors.base00}"; };
          activeWorkspace =    { border = "${themeColors.base03}"; background = "${themeColors.base03}"; text = "${themeColors.base00}"; };
          inactiveWorkspace =  { border = "${themeColors.base01}"; background = "${themeColors.base01}"; text = "${themeColors.base05}"; };
          urgentWorkspace =    { border = "${themeColors.base08}"; background = "${themeColors.base08}"; text = "${themeColors.base00}"; };
          bindingMode =        { border = "${themeColors.base05}"; background = "${themeColors.base05}"; text = "${themeColors.base00}"; };
        };
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status_conf.toml}";
        hiddenState = "show";
      }];
      colors = {
        focused = {
          border = "${themeColors.base05}";
          background = "${themeColors.base0A}";
          text = "${themeColors.base00}";
          indicator = "${themeColors.base0A}";
          childBorder = "${themeColors.base0A}";
        };
        focusedInactive = {
          border = "${themeColors.base01}";
          background = "${themeColors.base01}";
          text = "${themeColors.base05}";
          indicator = "${themeColors.base03}";
          childBorder = "${themeColors.base01}";
        };
        unfocused = {
          border = "${themeColors.base01}";
          background = "${themeColors.base00}";
          text = "${themeColors.base05}";
          indicator = "${themeColors.base01}";
          childBorder = "${themeColors.base01}";

        };
        urgent =
          { border = "${themeColors.base08}";
          background = "${themeColors.base08}";
          text = "${themeColors.base00}";
          indicator = "${themeColors.base08}";
          childBorder = "${themeColors.base08}";
        };
      };
    };
  };
  home.packages = with pkgs; [
    imv
    (python39.withPackages (ps: [
      ps.numpy
      ps.scipy
      ps.matplotlib
    ]))
    swaylock
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
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    TERM = "xterm-256color";
  };
  xdg.enable = true;
  home.file = {
    ".vim/UltiSnips/".source = pkgs.fetchFromGitHub {
      owner = "sinavir";
      repo = "ultisnip-snippets";
      rev = "09b4d4a720cb780a156fd487188bf192b58aa174";
      sha256 = "0l39gf0aivdbsqr3dqqa4mql8kkypggy3z0bgpzr96z17b6ylwj4";
    };
    ".config/swaylock/config".source = pkgs.substituteAll { src = ./swaylockConfig; photo = ./menou1.JPG; };
  };
}
