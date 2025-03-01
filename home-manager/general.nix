{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    playerctl
    nh
    vesktop

  ];
}
