{ config, user, pkgs, ... }:

{
  # # use 'systemctl --user' to interact
  # services.mpd = {
  #   enable = true;
  #   # considering changing config.xdg.userDirs.music directly? or maybe not?
  #   musicDirectory = "${config.home.homeDirectory}/Music/library";
  #   extraConfig = ''
  #     # prevent mpd from suddenly resuming
  #     restore_paused    "yes"

  #     # pipewire output
  #     audio_output {
  #       type "pipewire"
  #       name "My PipeWire output"
  #     }
  #   '';
  # };
  home.packages = with pkgs; [ mpd ];
}
