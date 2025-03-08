{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
     
      ./features
      ./bundles
    ];

  programs.nix-ld.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05"; # dont touch
}
