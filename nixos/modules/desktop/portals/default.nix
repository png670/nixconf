{ pkgs, lib, ... }:

{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # configPackages = with pkgs; [ xdg-desktop-portal-wlr ];
    configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  # enable configuring gtk themes in home-manager
  programs.dconf.enable = true;

}
