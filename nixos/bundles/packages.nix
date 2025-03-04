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
    papirus-nord
    nordic
    dunst
    picom
    kitty
    nitrogen
    lm_sensors
    st
  ];
  fonts.packages = with pkgs; [
    hack-font
    cm_unicode
    terminus_font
    libertinus
  ];


}
