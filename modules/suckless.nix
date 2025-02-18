
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (dmenu.overrideAttrs (_: { src = builtins.path { path = ../../.config/suckless/dmenu; }; }))
    (dwm.overrideAttrs (_: { src = builtins.path { path = ../../.config/suckless/dwm; }; }))
    (dwmblocks.overrideAttrs (_: { src = builtins.path { path = ../../.config/suckless/dwmblocks; }; }))
  ];
}
