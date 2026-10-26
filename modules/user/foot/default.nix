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
          background = "0d0606";
          foreground = "c4c1c1";
          regular0 = "0d0606";
          regular1 = "4F3D42";
          regular2 = "8D1C1A";
          regular3 = "8D1C1A";
          regular4 = "8F443A";
          regular5 = "8F6461";
          regular6 = "8D1C1A";
          regular7 = "c2c0c0";
          bright0 = "685555";
          bright1 = "4F3D42";
          bright2 = "8D1C1A";
          bright3 = "8D1C1A";
          bright4 = "8F443A";
          bright5 = "8F6461";
          bright6 = "8D1C1A";
          bright7 = "c2c0c0";
          alpha = "1.0";
        };
      };
    };
  };
}
