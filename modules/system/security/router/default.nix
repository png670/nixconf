{ config, lib, ... }:

let
  cfg = config.systemSettings.security.router;
in
{
  options.systemSettings.security.router = {
    enable = lib.mkEnableOption "NAT routing, DHCP and DNS for a LAN behind this host";

    wanInterface = lib.mkOption {
      type = lib.types.str;
    };

    lanInterface = lib.mkOption {
      type = lib.types.str;
    };

    lanAddress = lib.mkOption {
      type = lib.types.str;
      default = "192.168.50.1";
    };

    lanPrefixLength = lib.mkOption {
      type = lib.types.int;
      default = 24;
    };

    dhcpRange = lib.mkOption {
      type = lib.types.str;
      default = "192.168.50.50,192.168.50.200,24h";
    };

    lanNetwork = lib.mkOption {
      type = lib.types.str;
      default = "192.168.50.0/24";
    };

    upstreamDns = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "1.1.1.1"
        "9.9.9.9"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    networking.interfaces.${cfg.lanInterface} = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = cfg.lanAddress;
          prefixLength = cfg.lanPrefixLength;
        }
      ];
    };

    networking.interfaces.${cfg.wanInterface}.useDHCP = true;

    networking.nat = {
      enable = true;
      externalInterface = cfg.wanInterface;
      internalInterfaces = [ cfg.lanInterface ];
    };

    networking.nftables.enable = true;
    networking.firewall = {
      filterForward = true;

      # DNS and DHCP for the LAN. SSH is opened by systemSettings.security.sshd.
      interfaces.${cfg.lanInterface} = {
        allowedTCPPorts = [ 53 ];
        allowedUDPPorts = [
          53
          67
        ];
      };
    };

    services.dnsmasq = {
      enable = true;
      settings = {
        interface = [ cfg.lanInterface ];
        bind-interfaces = true;
        domain-needed = true; 
        bogus-priv = true; 
        dhcp-range = [ cfg.dhcpRange ];
        dhcp-option = [
          "option:router,${cfg.lanAddress}"
          "option:dns-server,${cfg.lanAddress}"
        ];
        server = cfg.upstreamDns;
      };
    };
  };
}
