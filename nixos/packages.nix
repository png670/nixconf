{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    elinks
    vesktop
    wget
    xclip
    zsh
    tmux
    alsa-utils
    killall
    htop
    neofetch
    neovim
    gh
    gcc
    stdenv
    mesa
    gnumake
    zlib
    pkg-config
    freetype
    sxiv
    mpv
    mpd
    prismlauncher
    qbittorrent
    flameshot
    brightnessctl
    terminus_font
    papirus-nord
    nordic
    dunst
    picom
    kitty
    nitrogen
    st
  ];


}
