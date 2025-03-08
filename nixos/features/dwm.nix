
{ config, pkgs, ... }:

let
  suckless = pkgs.fetchFromGitHub {
    owner = "png670";
    repo = "dwm";
    rev = "14774929057370d9e67622dcb55f8fa5a0fb2a01";
    hash = "sha256-kEEdUZwjmFytsO19TkTY5GNIX45PJ1+nQ1oVv1+cpkU=";
  };
in {
  services.xserver.enable = true;
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs (oldAttrs: {
      src = "${suckless}/dwm";
    });
  };

  environment.systemPackages = [
    (pkgs.dmenu.overrideAttrs (oldAttrs: {
      src = "${suckless}/dmenu";
    }))
    (pkgs.dwmblocks.overrideAttrs (oldAttrs: {
      src = "${suckless}/dwmblocks";
    }))
  ];
}
