{ config, lib, ... }:

let
  cfg = config.systemSettings.security.accessPoint;
in
{
  options.systemSettings.security.accessPoint = {
    enable = lib.mkEnableOption "a wifi access point (hostapd) on this host";

    interface = lib.mkOption {
      type = lib.types.str;
    };

    ssid = lib.mkOption {
      type = lib.types.str;
    };

    password = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };

    passwordFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
    };

    countryCode = lib.mkOption {
      type = lib.types.str;
      default = "GB";
    };

    band = lib.mkOption {
      type = lib.types.enum [ "2g" "5g" ];
      default = "5g";
    };

    channel = lib.mkOption {
      type = lib.types.int;
      default = 6;
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = (cfg.password != null) != (cfg.passwordFile != null);
        message = "set exactly one of password or passwordFile";
      }
    ];

    services.hostapd = {
      enable = true;
      radios.${cfg.interface} = {
        countryCode = cfg.countryCode;
        band = cfg.band;
        channel = cfg.channel;
        networks.${cfg.interface} = {
          ssid = cfg.ssid;
          authentication = {
            mode = "wpa2-sha1";
          } // (
            if cfg.passwordFile != null
            then { wpaPasswordFile = cfg.passwordFile; }
            else { wpaPassword = cfg.password; }
          );
        };
      };
    };

    networking.interfaces.${cfg.interface}.useDHCP = lib.mkDefault false;
  };
}
