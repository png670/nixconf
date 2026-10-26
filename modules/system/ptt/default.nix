{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.ptt;

  mic = pkgs.writeShellScript "ptt-mic" ''
    export XDG_RUNTIME_DIR="/run/user/$(${pkgs.coreutils}/bin/id -u)"
    exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ "$1"
  '';
in
{
  options.systemSettings.ptt = {
    enable = lib.mkEnableOption "system-wide push-to-talk";

    user = lib.mkOption {
      type = lib.types.str;
      default = "png76";
      description = "User whose PipeWire session is controlled, the hotkey daemon drops to this user.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.triggerhappy = {
      enable = true;
      user = cfg.user;
      bindings = [
        { keys = [ "LEFTALT" ]; event = "press";   cmd = "${mic} 0"; }
        { keys = [ "LEFTALT" ]; event = "release"; cmd = "${mic} 1"; }
      ];
    };
  };
}
