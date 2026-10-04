{ lib, config, ... }:

let
  cfg = config.systemSettings.security.gpg;
in
{
  options = {
    systemSettings.security.gpg = {
      enable = lib.mkEnableOption "the GnuPG agent with SSH support";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
