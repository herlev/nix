{
  config,
  pkgs,
  inputs,
  ...
}:
let
  dots = "${config.home.homeDirectory}/nix";
  symlink = path: config.lib.file.mkOutOfStoreSymlink "${dots}/${path}";
in
{
  imports = [
    ./modules/dunst.nix
    ./modules/espanso.nix
    ./modules/fish.nix
    ./modules/helix.nix
    ./modules/mpv.nix
    ./modules/tofi.nix
    ./modules/yazi.nix
    ./modules/zathura.nix
    ./modules/zoxide.nix
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

  programs.git = {
    enable = true;
    settings.user = {
      name = "herlev";
      email = "";
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
