{ config, pkgs, ... }:

let
    dwm = pkgs.dwm.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/png670/dwm-patched.git";
        };
    };

    dwmblocks = pkgs.dwmblocks.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/png670/dwmblocks-patched.git";
        };
    };

    dmenu = pkgs.dmenu.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/png670/dmenu.git";
        };
    };

in
{
    home = {
        file.".xinitrc".source = ./.xinitrc;
        file.".Xauthority".source = ./.Xauthority;

        packages = with pkgs; [
            dwm
            dwmblocks
            dmenu
            dunst # notification daemon
            libnotify # includes notify-send
            slock # X screen locker
            xorg.xkill
        ];
    };
}
