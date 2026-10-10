

{
  config,
  lib,
  osConfig ? { },
  ...
}:

let
  cfg = config.userSettings.swindle;
in
{
  options.userSettings.swindle = {
    enable = lib.mkEnableOption "the swindle configuration" // {
      default = osConfig.systemSettings.swindle.enable or false;
    };

    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/Pictures/mountains2.jpg";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."swindle/config.lua".text =
      lib.replaceStrings
        [ "@wallpaper@" ]
        [ (lib.escapeShellArg cfg.wallpaper) ]
        (builtins.readFile ./config/config.lua);
  };
}
