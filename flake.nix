{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    dmenu.url = "path:/home/png76/.config/dmenu";
    dwm.url = "path:/home/png76/.config/dwm";
    dwmblocks.url = "path:/home/png76/.config/dwmblocks";

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

	  ./modules
        ];
      };
    };
}
