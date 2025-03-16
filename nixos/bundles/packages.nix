{ config, pkgs, lib,  ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    lf
    wget
    xclip
    udiskie
    zsh
    tmux
    alsa-utils
    pamixer
    htop
    nh
    neofetch
    neovim
    mesa
    zlib
    freetype
    sxiv
    mpv
    prismlauncher
    flameshot
    brightnessctl
    dunst
    picom
    kitty
    lm_sensors
    xorg.xkill
    libnotify
    gnome-system-monitor

    #suckless
    st
    dunst
    slock

  ];
  fonts.packages = with pkgs; [
    hack-font
    cm_unicode
    terminus_font
    libertinus
  ];


}
