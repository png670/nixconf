{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  ## Outputs:

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      user   = "sui";
      system = "x86_64-linux";
      pkgs   = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs user;
        };
        modules = [
	  ./configuration.nix
	  ./packages.nix

          ./modules/unfree-merger.nix
	  ./modules/dwm.nix
	  ./modules/dwmblocks.nix
        ];
      };
    };
}
