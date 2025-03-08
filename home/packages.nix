{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    playerctl
    tree
    nh
    vesktop
    calcurse

  ];
}
