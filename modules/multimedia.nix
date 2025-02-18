
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  mpv
  sxiv
  mpd


  ];
}
