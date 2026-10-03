{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.security.bouncer;
  r = cfg.remote;
  routerCfg = config.systemSettings.security.router;
in
{
  options.systemSettings.security.bouncer = {
    enable = lib.mkEnableOption "enable soju on this host";

    port = lib.mkOption {
      type = lib.types.port;
      default = 6667;
    };

    remote = {
      enable = lib.mkEnableOption "exposing the bouncer through nginx with a real TLS cert";

      zoneDomain = lib.mkOption {
        type = lib.types.str;
      };

      hostName = lib.mkOption {
        type = lib.types.str;
      };

      acmeEmail = lib.mkOption {
        type = lib.types.str;
      };

      cloudflareEnvFile = lib.mkOption {
        type = lib.types.path;
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 6697;
      };

      updateInterval = lib.mkOption {
        type = lib.types.str;
        default = "5min";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      assertions = [
        {
          assertion = routerCfg.enable;
          message = "systemSettings.security.bouncer needs systemSettings.security.router.enable, since it scopes its firewall rules to the router's interfaces.";
        }
      ];

      services.soju.enable = true;
      services.soju.adminSocket.enable = true;
    }

    (lib.mkIf (!r.enable) {
      services.soju.listen = [ "irc+insecure://0.0.0.0:${toString cfg.port}" ];
      networking.firewall.interfaces.${routerCfg.lanInterface}.allowedTCPPorts = [ cfg.port ];
    })

    (lib.mkIf r.enable {
      services.soju.listen = [ "irc://localhost:${toString cfg.port}" ];

      systemd.services.cloudflare-ddns = {
        path = [ pkgs.curl pkgs.jq ];
        serviceConfig.Type = "oneshot";
        script = '' # what the fuckkk
          set -eu
          . ${r.cloudflareEnvFile}
          ip=$(curl -fsS https://api.ipify.org)
          zone_id=$(curl -fsS -H "Authorization: Bearer $CF_DNS_API_TOKEN" \
            "https://api.cloudflare.com/client/v4/zones?name=${r.zoneDomain}" | jq -r '.result[0].id')
          record_id=$(curl -fsS -H "Authorization: Bearer $CF_DNS_API_TOKEN" \
            "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records?type=A&name=${r.hostName}" | jq -r '.result[0].id')
          curl -fsS -X PUT -H "Authorization: Bearer $CF_DNS_API_TOKEN" -H "Content-Type: application/json" \
            --data "{\"type\":\"A\",\"name\":\"${r.hostName}\",\"content\":\"$ip\",\"ttl\":120,\"proxied\":false}" \
            "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$record_id"
        '';
      };

      systemd.timers.cloudflare-ddns = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "2min";
          OnUnitActiveSec = r.updateInterval;
        };
      };


      security.acme = {
        acceptTerms = true;
        defaults.email = r.acmeEmail;
        defaults.dnsResolver = "1.1.1.1:53";
        certs.${r.hostName} = {
          dnsProvider = "cloudflare";
          environmentFile = r.cloudflareEnvFile;
          reloadServices = [ "nginx" ];
          group = "nginx";
        };
      };

      systemd.services.nginx = {
        after = [ "acme-${r.hostName}.service" ];
        wants = [ "acme-${r.hostName}.service" ];
      };

      services.nginx = {
        enable = true;
        streamConfig = ''
          server {
            listen     ${toString r.port} ssl;
            listen     [::]:${toString r.port} ssl;
            proxy_pass 127.0.0.1:${toString cfg.port};

            ssl_certificate         ${config.security.acme.certs.${r.hostName}.directory}/fullchain.pem;
            ssl_certificate_key     ${config.security.acme.certs.${r.hostName}.directory}/key.pem;
            ssl_trusted_certificate ${config.security.acme.certs.${r.hostName}.directory}/chain.pem;
          }
        '';
      };

      networking.firewall.interfaces.${routerCfg.wanInterface}.allowedTCPPorts = [ r.port ];
      networking.firewall.interfaces.${routerCfg.lanInterface}.allowedTCPPorts = [ r.port ];
    })
  ]);
}
