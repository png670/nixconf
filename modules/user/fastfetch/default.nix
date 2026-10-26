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
        };

        modules = [
          "title"
          { type = "os";       key = "OS:";     format = "{name}"; }
          { type = "kernel";   key = "KERNEL:"; format = "{sysname}"; }
          { type = "shell";    key = "SHELL:"; }
          { type = "disk";     key = "FS:";     folders = "/"; }
          { type = "memory";   key = "MEMORY:"; }
          { type = "packages"; key = "PKGS:";   format = "{all}"; }
          { type = "wm";       key = "WM:"; }
        ];
      };
    };
  };
}
