
{
  description = "My nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    dwm = { url = "github:png670/dwm"; flake = false; };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      user   = "png76";
      system = "x86_64-linux";
      pkgs   = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit system inputs user pkgs;
          };
          modules = [
            ./nixos/configuration.nix
	    ./overlays
	    ./unfree-merger.nix
          ];
        };

      homeConfigurations.png76 = home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          extraSpecialArgs = { inherit user; };
          modules = [
            ./home-manager/home.nix
	    ./unfree-merger.nix
          ];
        };
    };
}
