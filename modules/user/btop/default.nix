{ config, lib, ... }:

{
  options.userSettings.btop.enable = lib.mkEnableOption "btop system monitor";

  config = lib.mkIf config.userSettings.btop.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        truecolor = false;
      };
    };
  };
}
