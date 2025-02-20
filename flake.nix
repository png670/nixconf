
{
  description = "My nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    dwm-patched.url = "github:png670/dwm-patched";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = inputs@{ self, nixpkgs, home-manager, dwm-patched, ... }:
    let
      user   = "png76";
      system = "x86_64-linux";
      pkgs   = import nixpkgs { inherit system; };
      dwm    = import dwm-patched { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit system inputs user pkgs dwm;
          };
          modules = [
            ./nixos/configuration.nix
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
