
{ config, lib, pkgs, ... }:

let
  sucklessSrc = builtins.fetchGit {
    url = ""ssh://git@github.com/png670/suckless-config.git;
    rev = "main";  # Replace with the actual commit hash
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
