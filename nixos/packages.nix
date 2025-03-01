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
    neofetch
    neovim
    mesa
    zlib
    freetype
    sxiv
    mpv
    prismlauncher
    qbittorrent
    flameshot
    brightnessctl
    papirus-nord
    nordic
    dunst
    picom
    kitty
    nitrogen
    st
  ];
  fonts.packages = with pkgs; [
    hack-font
    cm_unicode
    terminus_font
    libertinus
  ];


}
