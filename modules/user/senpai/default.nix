{ config, lib, ... }:

let
  cfg = config.userSettings.senpai;
in
{
  options.userSettings.senpai = {
    enable = lib.mkEnableOption "senpai IRC client";

    address = lib.mkOption {
      type = lib.types.str;
    };

    nick = lib.mkOption {
      type = lib.types.str;
    };

    passwordCommand = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.senpai = {
      enable = true;
      config = {
        address = cfg.address;
        nickname = cfg.nick;
        username = cfg.nick;
        password-cmd = cfg.passwordCommand;
        tls = true;
        pane-widths.channels = 0;
      };
    };
  };
}
