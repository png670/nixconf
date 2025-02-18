
{
  description = "my Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
       nixos = lib.nixosSystem {
         inherit system;
        modules = [
          ./configuration.nix
          ./modules
	  ./modules/dwm.nix
        ];

      };
    };

   };
}
