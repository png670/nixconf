{ config, lib, ... }:

let
  cfg = config.systemSettings.security.firewall;
in {
  options = {
    systemSettings.security.firewall = {
      enable = lib.mkEnableOption "Actvate firewall with ports open only for syncthing";
    };
  };

  config = lib.mkIf cfg.enable {
    # Firewall
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 21027 ];
      allowedUDPPorts = [ 22000 21027 ];
    };
  };
}
