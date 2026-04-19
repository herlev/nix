{ ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      sw = "sudo nixos-rebuild switch --flake /home/victor/nix";
      hm = "home-manager switch --flake /home/victor/nix";
      l = "lll"; # TODO why can't I overwrite 'l' otherwise
      ls = "eza -F";
      cat = "bat --paging=never --style=numbers,grid";
      ll = "ls -l";
      la = "ls -a";
      lsd = "ls -D";
      rm = "rm -vI"; # TODO: this interferes with the function yazi generates

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      ".-" = "cd -";

      week = "date +%V";
      publicip = "curl ifconfig.co";
      localip = "/bin/ip address show wlan0 | grep 'inet ' | awk '{print \$2}' | cut -d'/' -f1";
      ips = "/bin/ip -o addr | awk '!/^[0-9]*: ?lo|link\/ether/ {print \$2\" \"\$4}'";
      tds = "todos --blame --todo-types TODO,QUESTION,HACK,TEST,DEBUG,XXX,FIX,FIXME,FIXIT,BUG,ISSUE,FAILED";

      lsg = "ls -la --git";
      lg = "lazygit";

      tcd = "cd (mktemp -d)";
      colortest = "msgcat --color=test";
      octave = "octave --quiet";
      hn = "clx -n";

      open = "xdg-open";
      bopen = "b xdg-open";
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
}
