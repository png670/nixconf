
{ config, pkgs, ... }:

let
  dwm = pkgs.dwm.overrideAttrs (oldAttrs: {
    src = builtins.path { path = ./dwm; };
  });

  dwmblocks = pkgs.dwmblocks.overrideAttrs (oldAttrs: {
    src = builtins.path { path = ./dwmblocks; };
  });

  dmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = builtins.path { path = ./dmenu; };
  });

in {
  home.packages = [
    dwm
    dwmblocks
    dmenu
    pkgs.dunst       # Notification daemon
    pkgs.libnotify   # Includes notify-send
    pkgs.slock       # X screen locker
    pkgs.xorg.xkill  # Kill X windows
  ];
}
