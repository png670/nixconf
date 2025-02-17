{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Utilities
    firefox
    thunderbird
    elinks
    vesktop

    # Terminal Utilities
    neovim
    vim
    lf
    wget
    xclip
    zsh
    htop
    fastfetch
    neofetch
    gh
    gnumake
    pkg-config
    stdenv
    gcc

    # Window Manager
    st
    kitty
    nitrogen
    sxhkd
    picom
    eww
    dunst
    nordic
    papirus-nord
    flameshot
    brightnessctl
    terminus_font

    # Multimedia
    mpv
    sxiv

    # Development
    imlib2.dev
    xterm
    alsa-utils

    # Gaming
    steam-run
    qbittorrent
    prismlauncher

    # Other
    mesa
    zlib
    freetype
  ];
}
