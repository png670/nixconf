{ config, lib, ... }:

let
  cfg = config.systemSettings.security.accessPoint;
in
{
  options.systemSettings.security.accessPoint = {
    enable = lib.mkEnableOption "a Wi-Fi access point (hostapd) on this host";

    interface = lib.mkOption {
      type = lib.types.str;
    };

    ssid = lib.mkOption {
      type = lib.types.str;
    };

    passwordFile = lib.mkOption {
      type = lib.types.pathWith {
        inStore = false;
        absolute = true;
      };
    };

    countryCode = lib.mkOption {
      type = lib.types.str;
      default = "GB";
    };

    band = lib.mkOption {
      type = lib.types.enum [
        "2g"
        "5g"
      ];
      default = "5g";
    };

    channel = lib.mkOption {
      type = lib.types.int;
      default = 36;
    };
  };

  config = lib.mkIf cfg.enable {
    services.hostapd = {
      enable = true;
      radios.${cfg.interface} = {
        inherit (cfg) countryCode band channel;
        networks.${cfg.interface} = {
          ssid = cfg.ssid;
          authentication = {
            mode = "wpa2-sha1";
            wpaPasswordFile = cfg.passwordFile;
          };
        };
      };
    };

    networking.interfaces.${cfg.interface}.useDHCP = lib.mkDefault false;
  };
}
