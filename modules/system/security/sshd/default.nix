{ config, lib, ... }:

let
  cfg = config.systemSettings.security.sshd;
  inherit (config.systemSettings) adminUsers;
in
{
  options.systemSettings.security.sshd = {
    enable = lib.mkEnableOption "incoming SSH connections";

    authorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    openOn = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "tailscale0" ];
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = false; # per-interface below instead of every interface
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false; # PasswordAuthentication alone leaves PAM prompts open
        PermitRootLogin = "no";
        AllowUsers = adminUsers;
      };
    };

    networking.firewall.interfaces = lib.genAttrs cfg.openOn (_: {
      allowedTCPPorts = config.services.openssh.ports;
    });

    users.users = lib.genAttrs adminUsers (_: {
      openssh.authorizedKeys.keys = cfg.authorizedKeys;
    });
  };
}
