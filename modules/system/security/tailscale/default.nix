{ config, lib, ... }:

let
  cfg = config.systemSettings.security.tailscale;
  routerCfg = config.systemSettings.security.router;
in
{
  options.systemSettings.security.tailscale = {
    enable = lib.mkEnableOption "Enable tailscale on this host";

    authKeyFile = lib.mkOption {
      type = lib.types.path;
      default = "/etc/secrets/tailscale-authkey";
    };

    advertiseLanRoutes = lib.mkEnableOption;
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.advertiseLanRoutes -> routerCfg.enable;
        message = "systemSettings.security.tailscale.advertiseLanRoutes needs systemSettings.security.router.enable, since it advertises the router's own LAN network.";
      }
    ];

    services.tailscale = {
      enable = true;
      authKeyFile = cfg.authKeyFile;
      useRoutingFeatures = if cfg.advertiseLanRoutes then "server" else "client";
      extraUpFlags = lib.optionals cfg.advertiseLanRoutes [
        "--advertise-routes=${routerCfg.lanNetwork}"
      ];
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
