{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hardware-configuration.nix

      ./modules
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05"; # dont touch
}
