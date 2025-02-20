{ flake, lib, pkgs, system, ... }:
let

  inherit (flake) inputs;

in {


  nixpkgs.overlays = [
    (final: prev: {

      dmenu = prev.callPackage (inputs.dmenu + "/default.nix") {};
      dwm = prev.callPackage (inputs.dwm + "/default.nix") {};
      dwmblocks = prev.callPackage (inputs.st + "/default.nix") {};
        # namespaces
      );

    })
  ];
}
