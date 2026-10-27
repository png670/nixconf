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
        logo = {
          type = "file";
          source = "${./glenda.txt}";
          color = { "1" = "39"; };
          padding = { top = 1; left = 0; right = 4; };
        };

        display = {
          separator = " ";
          key.width = 10;
          color = { keys = "39"; title = "39"; };
          brightColor = false;
        };

        modules = [
          "title"
          { type = "os";       key = "os:";     format = "{name}"; }
          { type = "kernel";   key = "kernel:"; format = "{release}"; }
          { type = "shell";    key = "shell:"; }
          { type = "packages"; key = "pkgs:";   format = "{all}"; }
          { type = "wm";       key = "wm:"; }
          { type = "disk";   key = "fs:";  folders = "/"; format = "{size-used} ({size-percentage}) - {filesystem}"; }
          { type = "memory"; key = "ram:"; format = "{used} ({percentage})"; }
        ];
      };
    };
  };
}
