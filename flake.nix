{
  description = "png's nixos flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      # Every directory under ./hosts is a machine
      hosts = builtins.attrNames (
        lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts)
      );
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules = [
              { networking.hostName = host; }
              (./hosts + "/${host}")

              # shared modules, imported from modules/system/*/default.nix
              ./modules/system

              home-manager.nixosModules.home-manager
              {
	        home-manager = {
		  useGlobalPkgs = true;
		  useUserPackages = true;
		  extraSpecialArgs = { inherit inputs; };
		  backupFileExtension = "backup";
		};
              }
            ];
          };
        }) hosts
      );
    };
}
