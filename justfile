

install:
    sudo nixos-rebuild switch --flake .#YS7

install_bootloader:
    sudo nixos-rebuild boot --flake .#YS7

gc:
    nix-collect-garbage -d --delete-older-than 30d

update:
    nix flake update

list-generations:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
