{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.dwm.overrideAttrs (old: {
      src = ../suckless/dwm;
    }))
  ];
}
