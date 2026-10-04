{
  config,
  lib,
  pkgs,
  ...
}:

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

    passwordFile = lib.mkOption {
      type = lib.types.pathWith {
        inStore = false;
        absolute = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.senpai = {
      enable = true;
      config = {
        address = cfg.address;
        nickname = cfg.nick;
        username = cfg.nick;
        password-cmd = [
          (lib.getExe' pkgs.coreutils "cat")
          cfg.passwordFile
        ];
        tls = true;
        pane-widths.channels = 0;
      };
    };
  };
}
