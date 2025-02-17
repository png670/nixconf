
{ config, lib, pkgs, ... }:

{
  programs.dwm.enable = true;

  systemd.user.services.dwm = {
    Unit = {
      Description = "Dynamic Window Manager";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.dwm}/bin/dwm";
      Restart = "always";
    };

    wantedBy = [ "default.target" ]; # Correct way to enable it
  };

  environment.systemPackages = with pkgs; [ dwm ];
}
