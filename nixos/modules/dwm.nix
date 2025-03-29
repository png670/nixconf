{ config, pkgs, ... }:

let
  suckless = pkgs.fetchFromGitHub {
    owner = "png670";
    repo = "dwm";
    rev = "2839f13828742684ef3a43d83ee0cfd15b21a15e";
    hash = "sha256-lwA8IIyZhLYg31W+SboqunnfyIxtrfghZ/96uNNR828=";
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
    (pkgs.st.overrideAttrs (oldAttrs: {
      src = "${suckless}/st";
    }))
  ];
}
