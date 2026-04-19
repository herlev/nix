{ config, pkgs, inputs, ... }:
let
  dots = "${config.home.homeDirectory}/nix";
  symlink = path: config.lib.file.mkOutOfStoreSymlink "${dots}/${path}";
in
{
  imports = [
    ./modules/helix.nix
  ];
  home = {
    username = "victor";
    homeDirectory = "/home/victor";
    packages = with pkgs; [
      gdu
      dragon-drop
      libnotify
      networkmanagerapplet
      nsxiv
      yad
      tealdeer
      # hello
    ];

    file.".config/tmux" = {
      source = ./tmux;
      recursive = true;
    };

    file.".config/DankMaterialShell" = {
      # Symlink needed here for dms settings GUI to work
      source = symlink "dms";
    };

    file.".config/rustfmt" = {
      source = ./rustfmt;
      recursive = true;
    };

    stateVersion = "25.05";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      sw = "sudo nixos-rebuild switch --flake /home/victor/nix";
      hm = "home-manager switch --flake /home/victor/nix";
      l = "lll"; # TODO why can't I overwrite 'l' otherwise
      ls = "eza -F";
      cat="bat --paging=never --style=numbers,grid";
      ll="ls -l";
      la="ls -a";
      lsd="ls -D";
      rm="rm -vI"; # TODO: this interferes with the function yazi generates

      ".."="cd ..";
      "..."="cd ../..";
      "...."="cd ../../..";
      "....."="cd ../../../..";
      ".-"="cd -";

      week="date +%V";
      publicip="curl ifconfig.co";
      localip="/bin/ip address show wlan0 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1";
      ips="/bin/ip -o addr | awk '!/^[0-9]*: ?lo|link\/ether/ {print \$2\" \"\$4}'";
      tds="todos --blame --todo-types TODO,QUESTION,HACK,TEST,DEBUG,XXX,FIX,FIXME,FIXIT,BUG,ISSUE,FAILED";

      lsg="ls -la --git";
      lg="lazygit";

      tcd="cd (mktemp -d)";
      colortest="msgcat --color=test";
      octave="octave --quiet";
      hn="clx -n";

      open="xdg-open";
      bopen="b xdg-open";
    };
    shellInit = ''
      set -g fish_greeting
      # Enable colored man pages https://www.2daygeek.com/get-display-view-colored-colorized-man-pages-linux/
      set -xU MANROFFOPT "-P -c"
      set -xU LESS_TERMCAP_md (printf "\e[01;31m")
      set -xU LESS_TERMCAP_me (printf "\e[0m")
      set -xU LESS_TERMCAP_se (printf "\e[0m")
      set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
      set -xU LESS_TERMCAP_ue (printf "\e[0m")
      set -xU LESS_TERMCAP_us (printf "\e[01;32m")
    '';
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "herlev";
      email = "";
    };
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    keymap = {
      input.prepend_keymap = [
        {on = [ "<Esc>" ]; run = "close"; desc = "Cancel input";}
      ];
      mgr.prepend_keymap = [
        {on = [ "<C-n>" ]; run = ''shell 'dragon-drop -x "$1"' --confirm'';}
        {on = [ "?" ]; run = "help";}
      ];
    };
    settings = {
      mgr = {
        ratio = [0 3 4];
      };
    };
    shellWrapperName = "lll";
  };

  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "25%";
      padding-top = "25%";
      result-spacing = 25;
      num-results = 10;
      font = "/usr/share/fonts/TTF/JetBrainsMono-Regular.ttf";
      font-size = 12;
      background-color = "#223E";
      prompt-text = "open: ";
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      # recolor-lightcolor = "<BG>";
      # recolor-darkcolor = "<FG>";
      # default-bg = "<BG>";
      statusbar-basename = true;
      window-title-basename = true;
      page-padding = 1;
    };
    mappings = {
      u = "scroll half-up";
      d = "scroll half-down";
      D = "toggle_page_mode";
    };
  };

  programs.mpv = {
    enable = true;
    bindings = {
      j = "add volume -5";
      k = "add volume +5";
      h = "seek -10";
      l = "seek +10";
      H = "seek -60";
      L = "seek +60";
    };
  };

  services.espanso = {
    enable = true;
    waylandSupport = true;
    configs = {
      keyboard_layout = {layout = "dk"; variant = "nodeadkeys";};
      backed = "Clipboard";
      paste_shortcut = "CTRL+SHIFT+V";
    };
    matches = {
      base = [
        {
          trigger = ":date";
          replace = "{{mydate}}";
          vars = [
            {name = "mydate"; type = "date"; params.format = "%d/%m/%Y";}
          ];
        }
        {
          trigger = ":ddate";
          replace = "{{mydate}}";
          vars = [
            {name = "mydate"; type = "date"; params.format = "%Y/%m/%d";}
          ];
        }
        {
          trigger = ":zdate";
          replace = "{{mydate}}";
          vars = [
            {name = "mydate"; type = "date"; params.format = "%Y-%m-%d";}
          ];
        }
        { trigger = ":deg"; replace = "°"; }
      ];
    };
  };

  xdg.desktopEntries = {
    suspend = {
      name = "Suspend";
      exec = "systemctl suspend";
      type = "Application";
    };
    reboot = {
      name = "Reboot";
      exec = ''bash -c "yad --text '<big>Reboot?</big>' && systemctl reboot"'';
      type = "Application";
    };
    poweroff = {
      name = "Poweroff";
      exec = ''bash -c "yad --text '<big>Poweroff?</big>' && systemctl poweroff"'';
      type = "Application";
    };
    hibernate = {
      name = "Hibernate";
      exec = ''bash -c "yad --text '<big>Hibernate?</big>' && systemctl hibernate"'';
      type = "Application";
    };
  };

  services.network-manager-applet.enable = true;

  services.dunst = {
    enable = true;
    # https://dunst-project.org/documentation/
    settings = {
      global = {
        follow = "mouse";
        width = 300;
        height = 80;
        offset = 30;
        frame_color = "#ffffff"; # {{foreground}}
        idle_threshold = 120;
        line_height = 0;
        markup = "full";
        max_icon_size = 32;
      };
      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+mod1+space";
        context = "ctrl+shift+period";
      };

      # urgency_low = {
      #   background = "{{foreground}}";
      #   foreground = "{{background}}";
      #   timeout = 5;
      # };

      # urgency_normal = {
      #   background = "{{foreground}}";
      #   foreground = "{{background}}";
      #   timeout = 5;
      # };

      # urgency_critical = {
      #   background = "{{color9}}";
      #   foreground = "{{foreground}}";
      #   #frame_color = "#ff0000";
      #   timeout = 0;
      # };
    };
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "default";
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        vimium
        sidebery
      ];
      userChrome = ''
        #TabsToolbar {
            visibility: collapse
        }

        #sidebar-header{ display: none }
      '';
    };
  };

  programs.kitty = {
    # enable = true;
    # TODO
  };

  # TODO: rxiv tmux

}
