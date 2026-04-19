{ ... }:
{
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
}
