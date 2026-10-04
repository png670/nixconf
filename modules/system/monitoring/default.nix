{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.monitoring;
in
{
  options.systemSettings.monitoring.enable = lib.mkEnableOption "interactive system monitors and always-on bandwidth accounting";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      btop
      iftop
      nethogs
    ];

    # keeps long-term traffic totals (daily/monthly) even across reboots —
    services.vnstat.enable = true;
  };
}
