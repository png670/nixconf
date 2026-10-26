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
          background = "200a10";
          foreground = "c4c1c1";
          regular0 = "200a10";
          regular1 = "a82c3e";
          regular2 = "9c3a2c";
          regular3 = "a63e26";
          regular4 = "b04624";
          regular5 = "9a3050";
          regular6 = "bc6a2c";
          regular7 = "c4c1c1";
          bright0 = "6c5858";
          bright1 = "c93a4e";
          bright2 = "bd4a38";
          bright3 = "c8562a";
          bright4 = "cc5a28";
          bright5 = "b03e60";
          bright6 = "c4662c";
          bright7 = "c4c1c1";
          alpha = "1.0";
        };
      };
    };
  };
}
