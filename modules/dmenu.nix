{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.dmenu.overrideAttrs (old: {
      src = ../suckless/dmenu;
    }))
  ];
}
