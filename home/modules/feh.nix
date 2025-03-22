
{ config, lib, pkgs, ... }:

let
  wallpaperPath = "${config.home.homeDirectory}/Pictures/wallpaper3.png";
in
{
  systemd.user.services.feh = {
    Unit = {
      Description = "Set wallpaper with feh";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.feh}/bin/feh --bg-scale ${wallpaperPath}";
      Restart = "always";
      Environment = "DISPLAY=:0";
    };

    Install = { WantedBy = [ "default.target" ]; };
  };
}
