{ config, pkgs, inputs, outputs, ... }:

{
  imports =
    [
      outputs.homeManagerModules.default

    ];


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "png76";
  home.homeDirectory = "/home/png76";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.sessionVariables = {
     EDITOR = "nvim";
  };
  home.packages = with pkgs; [
    tree
    nh
    calcurse
    feh
    librewolf
    
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
