
{ config, pkgs, ... }:

let
  suckless = pkgs.fetchFromGitHub {
    owner = "png670";
    repo = "dwm";
    rev = "6e2692edfcb40ee4aa235dc5337d9eeef45e9e5c";
    hash = "sha256-w47Unze8ANSfZyP3V22Z4IGLw8sINIuZinr7Hsx8KxE=";
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
