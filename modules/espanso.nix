{ ... }:
{

  services.espanso = {
    enable = true;
    waylandSupport = true;
    configs = {
      keyboard_layout = {
        layout = "dk";
        variant = "nodeadkeys";
      };
      backed = "Clipboard";
      paste_shortcut = "CTRL+SHIFT+V";
    };
    matches = {
      base = [
        {
          trigger = ":date";
          replace = "{{mydate}}";
          vars = [
            {
              name = "mydate";
              type = "date";
              params.format = "%d/%m/%Y";
            }
          ];
        }
        {
          trigger = ":ddate";
          replace = "{{mydate}}";
          vars = [
            {
              name = "mydate";
              type = "date";
              params.format = "%Y/%m/%d";
            }
          ];
        }
        {
          trigger = ":zdate";
          replace = "{{mydate}}";
          vars = [
            {
              name = "mydate";
              type = "date";
              params.format = "%Y-%m-%d";
            }
          ];
        }
        {
          trigger = ":deg";
          replace = "°";
        }
      ];
    };
  };

}
