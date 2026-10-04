{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.security.openvpn;
in
{
  options = {
    systemSettings.security.openvpn = {
      enable = lib.mkEnableOption "OpenVPN";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.openvpn ];
    environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
  };
}
