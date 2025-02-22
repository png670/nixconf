{ config, user, pkgs, ... }:

{
  # # use 'systemctl --user' to interact
   services.mpd = {
     enable = true;
     musicDirectory = "${config.home.homeDirectory}/Music";
     extraConfig = ''
       # prevent mpd from suddenly resuming
       restore_paused    "yes"

       audio_output {
         type "pipewire"
         name "My PipeWire output"
       }
     '';
   };
  home.packages = with pkgs; [ mpd mpc ];
}
