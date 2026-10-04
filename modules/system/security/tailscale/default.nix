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
      description = "File holding the auth key; must not be in the Nix store.";
    };

    advertiseLanRoutes = lib.mkEnableOption "advertising this router's LAN as a Tailscale subnet route";

    trustTailnet = lib.mkEnableOption "accepting all traffic from tailnet peers";
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

      # Forwarding into the LAN is what a subnet route is for (the router
      # module filters forwarded traffic).
      extraForwardRules = lib.optionalString cfg.advertiseLanRoutes ''
        iifname "${tailnet}" oifname "${routerCfg.lanInterface}" accept
      '';
    };
  };
}
