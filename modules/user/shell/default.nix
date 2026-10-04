{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mksh
    bc
    fzf
  ];

  xdg.configFile."mksh/profile".source = ./config/profile;
  xdg.configFile."mksh/mkshrc".source = ./config/mkshrc;
}
