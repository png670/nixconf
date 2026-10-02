{ config, lib, ... }:

let
  cfg = config.systemSettings.security.sshd;
in {
  options = {
    systemSettings.security.sshd = {
      enable = lib.mkEnableOption "Enable incoming ssh connections";

      authorizedKeys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = lib.mkDefault true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    users.users = builtins.listToAttrs (map
      (user: {
        name = user;
        value.openssh.authorizedKeys.keys = cfg.authorizedKeys;
      })
      config.systemSettings.adminUsers);
  };
}
