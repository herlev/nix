{ ... }:
{
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
}
