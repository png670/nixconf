{ config, lib, ... }:

let
  cfg = config.userSettings.foot;
in
{
  options.userSettings.foot.enable = lib.mkEnableOption "foot terminal";

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          shell = "mksh";
          font = "GoMono Nerd Font:size=10";
          pad = "10x10";
          resize-by-cells = "no";
        };
        colors-dark = {
          background = "000407";
          foreground = "c1c2c3";
          regular0 = "080c12";
          regular1 = "838A9C";
          regular2 = "9097A8";
          regular3 = "9CA3B4";
          regular4 = "A7ABBA";
          regular5 = "9DACC2";
          regular6 = "B4B7C4";
          regular7 = "c1c2c3";
          bright0 = "57606a";
          bright1 = "838A9C";
          bright2 = "9097A8";
          bright3 = "9CA3B4";
          bright4 = "A7ABBA";
          bright5 = "9DACC2";
          bright6 = "B4B7C4";
          bright7 = "c1c2c3";
          alpha = "1.0";
        };
      };
    };
  };
}
