
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.dwmblocks.overrideAttrs (old: {
      src = ../suckless/dwmblocks;
    }))
  ];
}
