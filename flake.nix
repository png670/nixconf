
{
  description = "My Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    dwm.url = "github:png670/dwm";
    dwmblocks.url = "github:png670/dwmblocks";
    dmenu.url = "github:png670/dmenu";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs   = import nixpkgs { inherit system; };
    in
    {
      overlays.default = self.overlays.default;
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system inputs; };
        modules = [
          ./configuration.nix
          ./modules
        ];
      };
    };
}
