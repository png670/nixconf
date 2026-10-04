{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.ranger;
in
{
  options.userSettings.ranger.enable = lib.mkEnableOption "ranger file manager";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.ranger
      pkgs.ffmpegthumbnailer # video previews 
    ];

    xdg.configFile."ranger" = {
      source = ./config;
      recursive = true;
    };
  };
}
