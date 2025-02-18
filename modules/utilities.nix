
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

    # Add suckless programs (dwm, dwmblocks, dmenu) with direct paths to config
    (dwm.overrideAttrs (_: {
      src = /home/png76/.config/dwm;
    }))
    (dwmblocks.overrideAttrs (_: {
      src = /home/png76/.config/dwmblocks;
    }))
    (dmenu.overrideAttrs (_: {
      src = /home/png76/.config/dmenu;
    }))
  ];
}
