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
    steam-run
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

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam-unwrapped"
  ];


}
