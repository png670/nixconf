{ config, lib, pkgs, ... }:

{
  systemd.user.services.dwmblocks = {
    Unit = {
      Description = "Dwmblocks status bar";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.dwmblocks}/bin/dwmblocks";
      Restart = "always";
    };

    wantedBy = [ "default.target" ]; # Correct way to enable it
  };

  environment.systemPackages = with pkgs; [ dwmblocks ];
}
