{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.waybar;
in
{
  options.userSettings.waybar.enable = lib.mkEnableOption "waybar";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      waybar
      htop
      calcurse
      bmon
    ];

    xdg.configFile."waybar/config.jsonc".source = ./config/config.jsonc;
    xdg.configFile."waybar/style.css".source = ./config/style.css;
    xdg.configFile."waybar/waybar.css".source = ./config/waybar.css;
  };
}
