{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.desktopApps;
in
{
  options.systemSettings.desktopApps.enable = lib.mkEnableOption "temp packages";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      firefox
      thunar
      vesktop
      ufetch
      anki
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.go-mono
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      liberation_ttf
      dejavu_fonts
    ];
  };
}
