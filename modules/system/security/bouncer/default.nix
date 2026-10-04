{ config, lib, ... }:

let
  cfg = config.systemSettings.security.bouncer;
  r = cfg.remote;
  routerCfg = config.systemSettings.security.router;

  secretFile = lib.types.pathWith {
    inStore = false;
    absolute = true;
  };
in
{
  options.systemSettings.security.bouncer = {
    enable = lib.mkEnableOption "the soju IRC bouncer";

    port = lib.mkOption {
      type = lib.types.port;
      default = 6667;
    };

    remote = {
      enable = lib.mkEnableOption "exposing the bouncer through nginx with a real TLS cert";

      hostName = lib.mkOption {
        type = lib.types.str; # public name of the bouncer
      };

      acmeEmail = lib.mkOption {
        type = lib.types.str;
      };

      acmeCredentialsFile = lib.mkOption {
        type = secretFile;
      };

      ddnsTokenFile = lib.mkOption {
        type = secretFile;
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 6697;
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        services.soju.enable = true;
        services.soju.adminSocket.enable = true;
      }

      (lib.mkIf (!r.enable) {
        services.soju.listen = [ "irc+insecure://0.0.0.0:${toString cfg.port}" ];
        networking.firewall.interfaces.${routerCfg.lanInterface}.allowedTCPPorts = [ cfg.port ];
      })

      (lib.mkIf r.enable {
        services.soju.listen = [ "irc://localhost:${toString cfg.port}" ];

        services.cloudflare-dyndns = {
          enable = true;
          apiTokenFile = r.ddnsTokenFile;
          domains = [ r.hostName ];
        };

        security.acme = {
          acceptTerms = true;
          defaults.email = r.acmeEmail;
          defaults.dnsResolver = "1.1.1.1:53";
          certs.${r.hostName} = {
            dnsProvider = "cloudflare";
            environmentFile = r.acmeCredentialsFile;
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
          streamConfig =
            let
              certDir = config.security.acme.certs.${r.hostName}.directory;
            in
            ''
              server {
                listen     ${toString r.port} ssl;
                listen     [::]:${toString r.port} ssl;
                proxy_pass 127.0.0.1:${toString cfg.port};

                ssl_certificate         ${certDir}/fullchain.pem;
                ssl_certificate_key     ${certDir}/key.pem;
                ssl_trusted_certificate ${certDir}/chain.pem;
              }
            '';
        };

        networking.firewall.interfaces =
          lib.genAttrs [ routerCfg.wanInterface routerCfg.lanInterface ]
            (_: {
              allowedTCPPorts = [ r.port ];
            });
      })
    ]
  );
}
