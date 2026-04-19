{ pkgs, ... }:
{
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
        g.S = [
          "split_selection_on_newline"
          ":sort"
          "keep_primary_selection"
        ];
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
        "keyword" = {
          fg = "cyan";
        };
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
        "constructor" = {
          fg = "light-magenta";
          modifiers = [ "bold" ];
        };
        "function" = {
          fg = "yellow";
        };
        "function.macro" = "light-cyan";
        "function.builtin" = "light-yellow";
        "comment" = {
          fg = "gray";
          modifiers = [ "italic" ];
        };
        "constant" = {
          fg = "light-magenta";
        };
        "constant.builtin" = {
          fg = "cyan";
          modifiers = [ "bold" ];
        };
        "string" = "light-green";
        "number" = "light-magenta";
        "escape" = {
          modifiers = [ "bold" ];
        };
        "label" = "light-cyan";
        "tag" = "light-blue";

        "warning" = {
          fg = "light-yellow";
        };
        "error" = {
          fg = "light-red";
        };
        "info" = {
          fg = "light-cyan";
        };
        "hint" = {
          fg = "light-blue";
        };

        # "ui.background" = { bg = "bg" }
        "ui.linenr" = {
          fg = "gray";
        };
        "ui.linenr.selected" = {
          fg = "light-yellow";
        };
        "ui.statusline" = {
          bg = "black";
        };
        "ui.statusline.inactive" = {
          fg = "gray";
        };
        "ui.popup" = {
          bg = "black";
          fg = "light-gray";
        };
        "ui.window" = {
          fg = "black";
        };
        "ui.help" = {
          bg = "gray";
        };
        # "ui.text" = { fg = "fg" };
        # "ui.text.focus" = { fg = "fg" };
        "ui.selection" = {
          bg = "black";
        };
        # "ui.selection" = { bg = "#3a3d41" };
        # "ui.selection.primary" = { bg = "#264f78" };
        # "ui.cursor.primary" = { modifiers = ["reversed"] };
        # "ui.cursor.match" = { modifiers = ["reversed"] };

        "ui.cursor" = {
          fg = "gray";
          modifiers = [ "reversed" ];
        };
        "ui.cursor.primary" = {
          bg = "blue";
        };
        "ui.cursor.insert" = {
          bg = "light-red";
        };
        # "ui.cursor.match" = { bg = "#3a3d41", modifiers = ["underlined"] };

        "ui.menu" = {
          bg = "black";
        };
        "ui.menu.selected" = {
          fg = "black";
          bg = "light-blue";
          modifiers = [ "bold" ];
        };
        "ui.virtual.indent-guide" = "gray";
        "ui.virtual.whitespace" = "black";

        # "diagnostic" = { modifiers = ["underlined"] };
        # "diagnostic.error" = { underline = { style = "curl", color = "red" }, bg = "bg", fg = "red"};
        "diagnostic.hint" = {
          underline = {
            color = "blue";
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = "cyan";
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = "yellow";
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = "red";
            style = "curl";
          };
        };

        # "markup.heading" = { fg = "magenta", modifiers = ["bold"] };
        "markup.heading.1" = {
          fg = "magenta";
          modifiers = [ "bold" ];
        };
        "markup.heading.2" = {
          fg = "red";
          modifiers = [ "bold" ];
        };
        "markup.heading.3" = {
          fg = "yellow";
          modifiers = [ "bold" ];
        };
        "markup.heading.marker" = {
          fg = "gray";
          modifiers = [ "bold" ];
        };
        "markup.heading.4" = {
          fg = "green";
        };
        "markup.heading.5" = {
          fg = "cyan";
        };
        "markup.heading.6" = {
          fg = "blue";
        };
        # "markup.list.list_item" = "blue" # keep commented until bug is fixed;
        "markup.list" = "green";
        "markup.bold" = {
          fg = "yellow";
          modifiers = [ "bold" ];
        };
        "markup.italic" = {
          fg = "light-magenta";
          modifiers = [ "italic" ];
        };
        "markup.raw.inline" = {
          fg = "light-cyan";
          bg = "black";
          modifiers = [ "italic" ];
        };
        "markup.raw.block" = {
          fg = "light-gray";
        };
        "markup.link.url" = "cyan";
        "markup.link.text" = "light-green";
        "markup.quote" = {
          fg = "light-gray";
          modifiers = [ "italic" ];
        };
        # "markup.raw" = { fg = "foreground" };
        "diff.plus" = {
          fg = "green";
        };
        "diff.delta" = {
          fg = "yellow";
        };
        "diff.minus" = {
          fg = "red";
        };
      };
    };
  };
}
