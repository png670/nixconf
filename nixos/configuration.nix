# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/hardware-configuration.nix
      ./packages.nix

      ./modules
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

services.xserver.enable = true;
services.xserver.windowManager.dwm.enable = true;
services.displayManager.ly.enable = true;
services.picom.enable = true;

nixpkgs.config.allowUnfree = true;

nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  qt5.qtbase
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

environment.etc."xdg/dunst/dunstrc".source = "/home/png76/.config/dunst/dunstrc";

  system.stateVersion = "23.05";
}
