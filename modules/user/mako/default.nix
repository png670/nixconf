{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.mako;
in
{
  options.userSettings.mako = {
    enable = lib.mkEnableOption "mako notification daemon";

    output = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "DP-2";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.libnotify ];

    services.mako = {
      enable = true;
      settings = {
        font = "GoMono Nerd Font 8";
        format = "<b>%s</b>\\n%b"; # \n is literal — mako expands it itself
        sort = "-time";
        layer = "overlay";
        anchor = "top-right";
        background-color = "#000407";
        text-color = "#c1c2c3";
        width = 300;
        height = 110;
        margin = 8;
        padding = "0,5,10";
        border-size = 0;
        border-color = "#88c0d0";
        border-radius = 0;
        icons = 0;
        max-icon-size = 64;
        default-timeout = 5000;
        ignore-timeout = 1;

        "urgency=normal".border-color = "#d08770";
        "urgency=high" = {
          border-color = "#bf616a";
          default-timeout = 0;
        };
      }
      // lib.optionalAttrs (cfg.output != null) { inherit (cfg) output; };
    };
  };
}
