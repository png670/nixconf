{ lib, config, ... }:

let
  cfg = config.systemSettings.flatpak;
in
{
  options = {
    systemSettings.flatpak = {
      enable = lib.mkEnableOption "Flatpak";
    };
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
