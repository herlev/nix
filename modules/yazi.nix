{ ... }:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    keymap = {
      input.prepend_keymap = [
        {
          on = [ "<Esc>" ];
          run = "close";
          desc = "Cancel input";
        }
      ];
      mgr.prepend_keymap = [
        {
          on = [ "<C-n>" ];
          run = ''shell 'dragon-drop -x "$1"' --confirm'';
        }
        {
          on = [ "?" ];
          run = "help";
        }
      ];
    };
    settings = {
      mgr = {
        ratio = [
          0
          3
          4
        ];
      };
    };
    shellWrapperName = "lll";
  };

}
