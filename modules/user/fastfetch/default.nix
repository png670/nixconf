{ config, lib, ... }:
let
  cfg = config.userSettings.fastfetch;
in
{
  options.userSettings.fastfetch.enable = lib.mkEnableOption "fastfetch";

  config = lib.mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = { type = "builtin"; source = "alpine_small"; };

        display = {
          separator = " ";
          key.width = 6;
          color = { keys = "blue"; title = "blue"; };
          duration.abbreviation = true;
        };

        modules = [
          "title"
          { type = "os";       key = "os";     format = "{name}"; }
          { type = "host";     key = "host"; }
          { type = "kernel";   key = "kernel"; format = "{sysname}"; }
          { type = "uptime";   key = "uptime"; }
          { type = "memory";   key = "memory"; }
          { type = "packages"; key = "pkgs";   format = "{all}"; }
          { type = "wm";       key = "wm"; }
          "break"
          { type = "colors"; symbol = "block"; paddingLeft = 3; block.range = [ 0 7 ]; }
        ];
      };
    };
  };
}
