
{ config, lib, pkgs, ... }:

{
  systemd.user.services.picom = {
    Unit = {
      Description = "Picom compositor";
      After = [ "graphical-session.target" ];  # Ensure it starts after the session
    };

    Service = {
      ExecStart = "${pkgs.picom}/bin/picom";
      Restart = "always";
      Environment = "DISPLAY=:0 XDG_RUNTIME_DIR=%t";  # Ensure correct environment
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
