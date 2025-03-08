
{
  description = "pngs nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      user = "png76";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };  # ✅ Corrected syntax
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs user pkgs;
        };
        modules = [
          ./unfree-merger.nix
          ./nixos/configuration.nix
        ];
      };

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit user inputs system; };
        modules = [
          ./unfree-merger.nix
          ./home/home.nix
        ];
      };
    };
}
