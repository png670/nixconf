
{ config, pkgs, ... }:

let
  suckless = pkgs.fetchFromGitHub {
    owner = "png670";
    repo = "dwm";
    rev = "7cf898f7cd190eac2718fcfd830022957a87fbe3";
    hash = "sha256-LwksrbeJbw2wQTyRyCTySvonvsSJ98tbpj7tDngdLaU=";
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
