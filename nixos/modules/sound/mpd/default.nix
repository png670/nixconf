
{ config, lib, pkgs, ... }:

{
  options.png76 = {
    enable = lib.mkEnableOption "Enable MPD with PipeWire support";
  };

  config = lib.mkIf config.png76.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "/home/png76/Music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';
      user = user;
      network.listenAddress = "any";
      startWhenNeeded = true;
    };

    systemd.services.mpd.environment = {
      XDG_RUNTIME_DIR = "/run/user/1000";
    };

    environment.systemPackages = with pkgs; [ mpc ];
  };
}
