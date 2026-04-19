{ ... }:
{
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
}
