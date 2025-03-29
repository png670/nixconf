
{ config, pkgs, ... }:

let
  xmonadconfig = pkgs.fetchFromGitHub {
    owner = "png670";
    repo = "xmonad";
    rev = "113fa43e4539de31493c00f9036d62572a8d52ec";
    hash = "sha256-sy8EwJL/qQQmE4v1aneqnxHZMHFCs6LWK6hX+7FxCgQ=";
  };

  xmonadpkg = pkgs.xmonad-with-packages.override {
    extraPackages = hpkgs: with hpkgs; [
      xmonad-contrib
      xmonad-extras
      dbus
    ];
  };
in {
  services.xserver.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    package = xmonadpkg;
    config = "${xmonadconfig}/xmonad.hs";
  };
}
