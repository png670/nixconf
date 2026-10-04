{ config, lib, ... }:

let
  cfg = config.systemSettings.security.tailscale;
  routerCfg = config.systemSettings.security.router;
  tailnet = config.services.tailscale.interfaceName;
in
{
  options.systemSettings.security.tailscale = {
    enable = lib.mkEnableOption "Tailscale";

    authKeyFile = lib.mkOption {
      type = lib.types.pathWith {
        inStore = false;
        absolute = true;
      };
    };

    advertiseLanRoutes = lib.mkEnableOption;

    trustTailnet = lib.mkEnableOption;
  };

  config = lib.mkIf cfg.enable {

    services.tailscale = {
      enable = true;
      authKeyFile = cfg.authKeyFile;
      useRoutingFeatures = if cfg.advertiseLanRoutes then "server" else "client";
      extraUpFlags = lib.optionals cfg.advertiseLanRoutes [
        "--advertise-routes=${routerCfg.lanNetwork}"
      ];
    };

    networking.firewall = {
      trustedInterfaces = lib.optional cfg.trustTailnet tailnet;

      # Forwarding into the LAN is what a subnet route is for
      extraForwardRules = lib.optionalString cfg.advertiseLanRoutes ''
        iifname "${tailnet}" oifname "${routerCfg.lanInterface}" accept
      '';
    };
  };
}
