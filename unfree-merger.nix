{ lib, config, ... }:
{
  options = with lib; {
    nixpkgs.allowUnfreePackages = mkOption {
      type = with types; listOf str;
      default = [];
      example = [ "steam" "steam-original" "steam-unwrapped" ];
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowUnfreePackages;
  };
}
