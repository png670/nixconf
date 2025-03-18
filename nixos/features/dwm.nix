
{ config, pkgs, ... }:

let
  suckless = pkgs.fetchFromGitHub {
    owner = "png670";
    repo = "dwm";
    rev = "70f2c790c0bd2bc76e32d282aa3d0f58f1c53767";
    hash = "sha256-03KArYMi+dFWlquSJ7kJVwaQkPcVg1pcpCvZqBqAV8M=";
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
