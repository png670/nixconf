{
  description = "png's nixos flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, flake-parts, home-manager, sops-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { pkgs, ... }: {
        formatter = pkgs.nixfmt;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ git nixfmt ];
        };
      };

      flake =
        let
          lib = nixpkgs.lib;

          hosts = builtins.attrNames (
            lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts)
          );
        in
        {
          nixosConfigurations = builtins.listToAttrs (
            map (host: {
              name = host;
              value = lib.nixosSystem {
                system = null;
                specialArgs = { inherit inputs; };
                modules = [
                  { networking.hostName = host; }
                  (./hosts + "/${host}")

                  ./modules/system

                  sops-nix.nixosModules.sops

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
    };
}
