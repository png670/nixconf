
{
  description = "Gpt's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    # Boilerplate-reducing lib with helper functions
    myLib = import ./myLib/default.nix {inherit inputs;};
  in
    with myLib; {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        laptop = mkSystem ./hosts/laptop/configuration.nix;
        #        desktop = mkSystem ./hosts/desktop/configuration.nix; # Fixed path
      };

      homeConfigurations = {
        # ================ Maintained Home Configurations ================ #

        "png76-laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;
        #        "png76-desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix; # Fixed path
      };

      # Modules for NixOS and Home-Manager
      homeManagerModules.default = ./home/modules;
      nixosModules.default = ./nixos/modules;
    };
}
