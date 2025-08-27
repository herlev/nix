{
  description = "";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };

  outputs = {self, nixpkgs, ...}:
  let lib = nixpkgs.lib; in {
    nixosConfigurations = {
      YS7 = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
}
