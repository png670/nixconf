{ config, lib, ... }:

let
  cfg = config.systemSettings.syncthing;
in
{
  options.systemSettings.syncthing.openFirewall = lib.mkEnableOption "the ports Syncthing needs. Syncthing itself is not managed here (it is run by the user)";

  config = lib.mkIf cfg.openFirewall {
    networking.firewall = {
      allowedTCPPorts = [ 22000 ]; # sync protocol
      allowedUDPPorts = [
        22000 # sync protocol (QUIC)
        21027 # local discovery
      ];
    };
  };
}
