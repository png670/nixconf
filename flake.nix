{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ## Outputs:

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      user   = "png76";
      system = "x86_64-linux";
      pkgs        = import nixpkgs        { inherit system; };
      pkgs-stable = import nixpkgs-stable { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit system inputs user pkgs-stable;
          };
          modules = [
            ./unfree-merger.nix
            ./nixos/configuration.nix
          ];
        };
      homeConfigurations.sui = home-manager.lib.homeManagerConfiguration
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
