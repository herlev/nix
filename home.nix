{ config, pkgs, ... }:
{
  home = {
    username = "victor";
    homeDirectory = "/home/victor";
    packages = with pkgs; [
      # hello
    ];

    stateVersion = "25.05";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      sw = "sudo nixos-rebuild switch --flake /home/victor/nix";
      hm = "home-manager switch --flake /home/victor/nix";
    };
    shellInit = ''
      set -g fish_greeting
    '';
  };

  programs.git = {
    enable = true;
    userName = "herlev";
    userEmail = "";
  };

}
