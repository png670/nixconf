{
  description = "png's nixos flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

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
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      home-manager,
      sops-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        { pkgs, system, ... }:
        {
          formatter = pkgs.nixfmt;

          # builds every host that runs on this system.
          checks =
            lib.mapAttrs' (host: nixos: lib.nameValuePair "host-${host}" nixos.config.system.build.toplevel) (
              lib.filterAttrs (_: nixos: nixos.pkgs.stdenv.hostPlatform.system == system) self.nixosConfigurations
            )

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              git
              nixfmt
            ];
          };
        };

      # Every directory under ./hosts is a host
      flake.nixosConfigurations =
        let
          hostNames = lib.attrNames (
            lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts)
          );

          mkHost =
            host:
            lib.nixosSystem {
              system = null; # the platform comes from hardware-configuration.nix
              specialArgs = { inherit inputs; };
              modules = [
                { networking.hostName = host; }
                ./hosts/${host}/configuration.nix
                ./hosts/${host}/hardware-configuration.nix
                ./modules/system

                sops-nix.nixosModules.sops
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit inputs; };
                    backupFileExtension = "backup";
                    overwriteBackup = true;
                    sharedModules = [
                      ./modules/user
                      ./hosts/${host}/home.nix
                    ];
                  };
                }
              ];
            };
        in
        lib.genAttrs hostNames mkHost;
    };
}
