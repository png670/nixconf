{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.userSettings.serein;

  # XWayland, so Mod+Q can hide Serein to the tray on swindle.
  serein = pkgs.symlinkJoin {
    name = "serein";
    paths = [ inputs.serein.packages.${pkgs.stdenv.hostPlatform.system}.serein ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = "wrapProgram $out/bin/serein --unset WAYLAND_DISPLAY";
  };
in
{
  options.userSettings.serein.enable = lib.mkEnableOption "Serein";

  config = lib.mkIf cfg.enable {
    home.packages = [ serein ];
  };
}
