{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.security.doas;
  inherit (config.systemSettings) adminUsers;
in
{
  options.systemSettings.security.doas.enable = lib.mkEnableOption "doas in place of sudo";

  config = lib.mkIf cfg.enable {
    security.sudo.enable = false;
    security.doas = {
      enable = true;
      extraRules = [
        {
          users = adminUsers;
          persist = true; # ask once, then not again for a few minutes
        }
      ];
    };

    environment.systemPackages = [ pkgs.doas-sudo-shim ];
  };
}
