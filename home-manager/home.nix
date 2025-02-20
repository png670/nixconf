{ config, pkgs, ... }:

{
  imports =
    [
      ./modules
      ./overlays

      ./packages.nix
    ];


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "png76";
  home.homeDirectory = "/home/png76";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
  ];

  home.sessionVariables = {
     EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
