# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ./modules/kbct.nix
  ];


  fileSystems."/mnt/arch" = { # os-prober hangs if this is not mounted
    device = "/dev/nvme0n1p3";
    fsType = "ext4";
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "YS7"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.victor = {
    isNormalUser = true;
    description = "victor";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = pkgs: {
    kbct = pkgs.callPackage ./pkgs/kbct.nix { };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
    fish
    tmux

    # dev
    git
    gcc
    pkg-config
    cargo

    # LSPs
    nil # Nix

    os-prober

    # DE stuff
    waybar
    avizo # volumectl lightctl
    dunst
    kitty
    tofi
    swww
    pulsemixer
    pinentry-gtk2 # this installs multiple, configurable which one to use
    blueberry
    zathura
    nwg-displays
    nsxiv
    udiskie
    kbct

    # image/vector graphics
    gimp3
    inkscape

    # cad
    freecad-wayland
    solvespace
    f3d
    
    grim
    slurp

    # network
    wireguard-tools # **
    wireshark

    # cli tools
    ripgrep
    fd
    bat
    eza
    fzf
    libqalculate
    tio
    bottom
    
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs = {
    fish.enable = true;

    firefox.enable = true;
    thunderbird.enable = true;
    kdeconnect.enable = true;

    nm-applet.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  services = {
    playerctld.enable = true;
    kbct = {
      enable = true;
      config = ''
        - keyboards: ["AT Translated Set 2 keyboard"]
          keymap:
            leftalt: leftctrl
            leftctrl: leftalt
            capslock: reserved
          layers:
            - modifiers: ['capslock']
              keymap:
                i: up
                j: left
                k: down
                l: right
                y: pageup
                h: pagedown
                u: home
                o: end
                semicolon: esc
      '';
      package = pkgs.kbct;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
