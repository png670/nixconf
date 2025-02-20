
{
  description = "My nix flake";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";  # Only using stable

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";  # Use stable nixpkgs
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
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
            ./unfree-merger.nix
            ./nixos/configuration.nix
          ];
        };

      homeConfigurations.png76 = home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          extraSpecialArgs = { inherit user; };
          modules = [
            ./unfree-merger.nix
            ./home-manager/home.nix
          ];
        };
    };
}
