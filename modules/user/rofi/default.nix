{ config, lib, pkgs, ... }:

let
  cfg = config.userSettings.rofi;
in
{
  options.userSettings.rofi.enable = lib.mkEnableOption "rofi launcher";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.rofi ];

    xdg.configFile."rofi/config.rasi".source = ./config/config.rasi;
  };
}
