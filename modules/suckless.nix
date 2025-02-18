
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (dmenu.overrideAttrs (_: { src = ../../.config/suckless/dmenu; }))
    (dwm.overrideAttrs (_: { src = ../../.config/suckless/dwm; }))
    (dwmblocks.overrideAttrs (_: { src = ../../.config/suckless/dwmblocks; }))
  ];
}
