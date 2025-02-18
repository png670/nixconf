{ pkgs, ... }:

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
