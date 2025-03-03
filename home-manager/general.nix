{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    playerctl
    vesktop

  ];
}
