{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    dmenu.url = "git+https://github.com/png670/dmenu.git";
    dwm.url = "git+https://github.com/png670/dwm.git";
    dwmblocks.url = "git+https://github.com/png670/dwmblocks.git";

  };

  ## Outputs:

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs   = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs;
        };
        modules = [
	  ./configuration.nix

	  ./modules
        ];
      };
    };
}
