{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/hardware-configuration.nix
      ./packages.nix

      ./modules
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

nix.settings.experimental-features = [ "nix-command" "flakes" ];
environment.etc."xdg/dunst/dunstrc".source = "/home/png76/.config/dunst/dunstrc";

  system.stateVersion = "23.05"; # dont touch
}
