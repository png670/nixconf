
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.cFprintd;
in
{
  options.services.cFprintd = {
    enable = mkEnableOption "Enable fingerprint authentication with fprintd";
  };

  config = mkIf cfg.enable {
    services.fprintd.enable = true;

    security.pam.services = {
      ly.fprintAuth = true;     # Enable fingerprint auth in Ly display manager
      login.fprintAuth = true;  # Enable fingerprint auth for TTY login
    };

    environment.systemPackages = with pkgs; [
      fprintd
      libfprint
      fprintd-clients  # Optional CLI/GUI tools for fingerprint management
    ];
  };
}
