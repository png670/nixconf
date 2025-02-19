{ config, pkgs, ... }:

let
    dwm = pkgs.dwm.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/png670/dwm.git";
        };
    };

    dwmblocks = pkgs.dwmblocks.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/png670/dwmblocks.git";
        };
    };
in
{
    home = {
        file.".xinitrc".source = ./xinitrc;
        file.".Xauthority".source = ./Xauthority;

        packages = with pkgs; [
            dwm
            dwmblocks
            dmenu
            dunst # notification daemon
            libnotify # includes notify-send
            scrot # for takin screenshots
            slock # X screen locker

            # clipboard utils
            xclip
            xsel

            xorg.xkill
        ];
    };
}
