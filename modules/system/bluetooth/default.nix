{ lib, config, ... }:

let
  cfg = config.systemSettings.bluetooth;
in
{
  options = {
    systemSettings.bluetooth = {
      enable = lib.mkEnableOption "Bluetooth and the blueman applet";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
    };
    services.blueman.enable = true;
  };
}
