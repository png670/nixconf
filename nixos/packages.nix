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
    nerd-fonts.hack
    libertinus
    terminus_font


  ];

}
