{ config, lib, pkgs, ... }:

{
  options = {
    programs.dwm.enable = lib.mkEnableOption "dwm window manager";
  };

  config = lib.mkIf config.programs.dwm.enable {
    environment.systemPackages = with pkgs; [ dwm ];
    services.xserver.windowManager.session = [{
      name = "dwm";
      start = ''
        exec dwm
      '';
    }];
  };
}
