
{
  description = "My nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";  # Using stable

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/ed91a20c84a80a525780dcb5ea3387dddf6cd2de";
  };


  outputs = { self, nixpkgs, home-manager, stylix, ... } @ inputs:
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
          extraSpecialArgs = { inherit user inputs; };  # ✅ Fix: Pass inputs
          modules = [
            ./unfree-merger.nix
            ./home-manager/home.nix

	    stylix.homeManagerModules.stylix
          ];
        };
    };
}
