{ config, lib, pkgs, ... }:

{
  options = {
    programs.dwmblocks.enable = lib.mkEnableOption "dwmblocks status bar";
  };

  config = lib.mkIf config.programs.dwmblocks.enable {
    environment.systemPackages = with pkgs; [ dwmblocks ];
    systemd.user.services.dwmblocks = {
      Service = {
        ExecStart = "${pkgs.dwmblocks}/bin/dwmblocks";
        Restart = "always";
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };
}
