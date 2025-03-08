
{ config, pkgs, ... }:

let
  suckless = pkgs.fetchFromGitHub {
    owner = "png670";
    repo = "dwm";
    rev = "7257b01068ea908ce89017504f677d3cb49d54";
    hash = "sha256-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  };
in {
  services.xserver.enable = true;
  services.xserver.windowManager.dwm = {
      enable = true;
    package = pkgs.dwm.overrideAttrs (oldAttrs: {
      src = "${suckless}/dwm";
    });
  };

  programs.dmenu = {
    enable = true;
    package = pkgs.dmenu.overrideAttrs (oldAttrs: {
      src = "${suckless}/dmenu";
    });
  };

  services.dwmblocks = {
    enable = true;
    package = pkgs.dwmblocks.overrideAttrs (oldAttrs: {
      src = "${suckless}/dwmblocks";
    });
  };
}
