{ config, pkgs, ... }:
{
  home = {
    username = "victor";
    homeDirectory = "/home/victor";
    packages = with pkgs; [
      gdu
      dragon-drop
      libnotify
      networkmanagerapplet
      nsxiv
      # hello
    ];

    file.".config/tmux" = {
      source = ./tmux;
      recursive = true;
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
    userName = "herlev";
    userEmail = "";
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

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nil # Nix
    ];
    settings = {
      theme = "custom";
      editor = {
        # Minimum severity to show a diagnostic on the primary cursor's line.
        # Note that `cursor-line` diagnostics are hidden in insert mode.
        inline-diagnostics.cursor-line = "error";
        end-of-line-diagnostics = "hint";
        line-number = "relative";
        indent-guides.render = true;
        whitespace.render = "all";
        whitespace.characters = {
          newline = "¬";
          nbsp = "~";
          tab = "→";
        };
        bufferline = "multiple";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys.normal = {
        backspace = ":bclose";
        "C-p" = "goto_previous_buffer";
        "C-n" = "goto_next_buffer";

        J = "goto_next_paragraph";
        K = "goto_next_paragraph";
        "C-j" = "join_selections";
        "C-x" = "hsplit";
        "C-y" = "vsplit";

        "æ" = "flip_selections";
        g.S = ["split_selection_on_newline" ":sort" "keep_primary_selection"];
        D = "remove_primary_selection";
        "}" = "rotate_selection_contents_forward";
        "{" = "rotate_selection_contents_backward";
        g."," = "@mimS, "; # TODO: enter here

        "C-t" = ":tree-sitter-scopes";
        "C-h" = ":tree-sitter-subtree";
        "C-r" = ":tree-sitter-highlight-name";

        "C-v" = "@vmiw*n";
        space = {
          b = "no_op";
          space = "buffer_picker";
          # https://github.com/helix-editor/helix/discussions/6421
          B = ":sh blame %{buffer_name} %{cursor_line}"; # Show blame information
          U = ":sh blame --url-only %{cursor_line} %{buffer_name} | xargs -I{} xdg-open {}"; # Open PR or commit url in browser
        };
      };
      keys.select = {
        "J" = "goto_next_paragraph";
        "K" = "goto_prev_paragraph";
        "C-j" = "join_selections";
        "æ" = "flip_selections";
      };
    };
    themes = {
      custom = {
        # TODO
        # highlight diagnostics/warnings/errors
        # look at base16_terminal.toml for a theme that does mostly the same as this

        "attribute" = "light-yellow";
        "keyword" = { fg = "cyan"; };
        "keyword.storage.modifier" = "light-gray";
        "keyword.directive" = "red";
        "module" = "light-green";
        "namespace" = "green";
        "punctuation" = "white";
        "punctuation.delimiter" = "light-gray";
        "operator" = "light-magenta";
        "special" = "magenta";
        "property" = "light-blue";
        "variable.property" = "light-blue";
        "variable" = "light-blue";
        "variable.builtin" = "light-yellow";
        # "variable.parameter" = "#ff0000"
        "type" = "green";
        "type.builtin" = "green";
        "constructor" = { fg = "light-magenta"; modifiers = ["bold"]; };
        "function" = { fg = "yellow"; };
        "function.macro" = "light-cyan";
        "function.builtin" = "light-yellow";
        "comment" = { fg = "gray"; modifiers = ["italic"];  };
        "constant" = { fg = "light-magenta"; };
        "constant.builtin" = { fg = "cyan"; modifiers = ["bold"]; };
        "string" = "light-green";
        "number" = "light-magenta";
        "escape" = { modifiers = ["bold"]; };
        "label" = "light-cyan";
        "tag" = "light-blue";

        "warning" = { fg = "light-yellow"; };
        "error" = { fg = "light-red"; };
        "info" = { fg = "light-cyan"; };
        "hint" = { fg = "light-blue"; };

        # "ui.background" = { bg = "bg" }
        "ui.linenr" = { fg = "gray"; };
        "ui.linenr.selected" = { fg = "light-yellow"; };
        "ui.statusline" = { bg = "black"; };
        "ui.statusline.inactive" = { fg = "gray"; };
        "ui.popup" = { bg = "black"; fg = "light-gray"; };
        "ui.window" = { fg = "black"; };
        "ui.help" = { bg = "gray"; };
        # "ui.text" = { fg = "fg" };
        # "ui.text.focus" = { fg = "fg" };
        "ui.selection" = { bg = "black"; };
        # "ui.selection" = { bg = "#3a3d41" };
        # "ui.selection.primary" = { bg = "#264f78" };
        # "ui.cursor.primary" = { modifiers = ["reversed"] };
        # "ui.cursor.match" = { modifiers = ["reversed"] };

        "ui.cursor" = { fg = "gray"; modifiers = ["reversed"]; };
        "ui.cursor.primary" = { bg = "blue"; };
        "ui.cursor.insert" = { bg = "light-red"; };
        # "ui.cursor.match" = { bg = "#3a3d41", modifiers = ["underlined"] };

        "ui.menu" = { bg = "black"; };
        "ui.menu.selected" = { fg = "black"; bg = "light-blue"; modifiers = ["bold"]; };
        "ui.virtual.indent-guide" = "gray";
        "ui.virtual.whitespace" = "black";

        # "diagnostic" = { modifiers = ["underlined"] };
        # "diagnostic.error" = { underline = { style = "curl", color = "red" }, bg = "bg", fg = "red"};
        "diagnostic.hint" = { underline = { color = "blue"; style = "curl"; }; };
        "diagnostic.info" = { underline = { color = "cyan"; style = "curl"; }; };
        "diagnostic.warning" = { underline = { color = "yellow"; style = "curl"; }; };
        "diagnostic.error" = { underline = { color = "red"; style = "curl"; }; };

        # "markup.heading" = { fg = "magenta", modifiers = ["bold"] };
        "markup.heading.1" = { fg = "magenta"; modifiers = ["bold"]; };
        "markup.heading.2" = { fg = "red"; modifiers = ["bold"]; };
        "markup.heading.3" = { fg = "yellow"; modifiers = ["bold"]; };
        "markup.heading.marker" = { fg = "gray"; modifiers = ["bold"]; };
        "markup.heading.4" = { fg = "green"; };
        "markup.heading.5" = { fg = "cyan"; };
        "markup.heading.6" = { fg = "blue"; };
        # "markup.list.list_item" = "blue" # keep commented until bug is fixed;
        "markup.list" = "green";
        "markup.bold" = { fg = "yellow"; modifiers = ["bold"]; };
        "markup.italic" = { fg = "light-magenta"; modifiers = ["italic"]; };
        "markup.raw.inline" = { fg = "light-cyan"; bg = "black"; modifiers = ["italic"]; };
        "markup.raw.block" = { fg = "light-gray"; };
        "markup.link.url" = "cyan";
        "markup.link.text" = "light-green";
        "markup.quote" = { fg = "light-gray"; modifiers = ["italic"]; };
        # "markup.raw" = { fg = "foreground" };
        "diff.plus" = { fg = "green"; };
        "diff.delta" = { fg = "yellow"; };
        "diff.minus" = { fg = "red"; };
      };
    };
  };
}
