{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.audio;
in
{
  options.systemSettings.audio.enable = lib.mkEnableOption "PipeWire audio stack and desktop audio utilities";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alsa-utils
      mpv
      pavucontrol
    ];

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
