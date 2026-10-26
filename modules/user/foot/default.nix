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
          font = "Libertinus Mono:size=10";
          pad = "10x10";
          resize-by-cells = "no";
        };
        colors-dark = {
          background = "150a09";
          foreground = "c4c1c1";
          regular0 = "150a09";
          regular1 = "b02a2c";
          regular2 = "a02e22";
          regular3 = "b43a2e";
          regular4 = "a62428";
          regular5 = "821c22";
          regular6 = "9a3030";
          regular7 = "c4c1c1";
          bright0 = "6c5656";
          bright1 = "d43030";
          bright2 = "c83a2c";
          bright3 = "d4443a";
          bright4 = "c82c30";
          bright5 = "a4262c";
          bright6 = "c04440";
          bright7 = "c4c1c1";
          alpha = "1.0";
        };
      };
    };
  };
}
