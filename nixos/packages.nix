{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    vesktop
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
