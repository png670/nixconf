
{ config, pkgs, ... }:

let
  xmonadconfig = pkgs.fetchFromGitHub {
    owner = "png670";
    repo = "xmonad";
    rev = "d15be84caf3153f17d5fec94be54df8bf53ccb44";
    hash = "sha256-tYouKuCA9KLbjLYHYqk8V1Kkp6W7ZaRXUOM3UCsrkME=";
  };

in {
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "none+xmonad";
    desktopManager = {
      xterm.enable = false;
    };
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = pkgs: [ pkgs.xmobar ];  # Fixed the extraPackages line
      };
    };
  };
}
