{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    playerctl
    tree
    nh
    vesktop
    calcurse
    feh
    
    materia-theme
    papirus-icon-theme
  ];
}
