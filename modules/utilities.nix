
{ pkgs, config, ... }:

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
    (dmenu.overrideAttrs (_: { src = /home/png76/.config/dmenu; }))
    (dwm.overrideAttrs (_: { src = /home/png76/.config/dwm; }))
    (dwmblocks.overrideAttrs (_: { src = /home/png76/.config/dwmblocks; }))

  ];
}
