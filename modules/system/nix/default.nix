
{ ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;

  nix.gc.automatic = false;
  
  programs.nix-ld.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 2";
    flake = "/home/png76/nixos"; 
  };

  nixpkgs.config.allowUnfree = true;
}
