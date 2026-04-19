{ ... }:
{
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

}
