
{ config, lib, pkgs, ... }:

let
  sucklessSrc = builtins.fetchGit {
    url = "git@github.com:png670/suckless-config.git";
    rev = "5550aa61e27686b56df52c4b25615d2cba89f939";  # Replace with the actual commit hash
  };
in
{
  # Add suckless programs to systemPackages
  environment.systemPackages = with pkgs; [
    (dmenu.overrideAttrs (_: { src = "${sucklessSrc}/dmenu"; }))
    (dwm.overrideAttrs (_: { src = "${sucklessSrc}/dwm"; }))
    (dwmblocks.overrideAttrs (_: { src = "${sucklessSrc}/dwmblocks"; }))
  ];
}
