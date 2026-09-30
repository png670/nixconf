{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    thunar
    vesktop
    ufetch
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.go-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    liberation_ttf
    dejavu_fonts
    nerd-fonts.symbols-only
  ];

  fonts.fontconfig.enable = true;
}
