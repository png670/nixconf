{
  description = "my flake Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  # Outputs
  outputs = { self, nixpkgs, dwm, dwmblocks, dmenu, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      # NixOS Configuration
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self; };
        modules = [
          ./configuration.nix

          ./modules
        ];
      };
    };
}
