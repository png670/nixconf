{ config, lib, ... }:

let
  cfg = config.systemSettings.networkManager;
in
{
  options.systemSettings.networkManager.enable =
    lib.mkEnableOption "NetworkManager";

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.backend = "iwd";
  };
}
