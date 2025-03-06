
{ config, pkgs, ... }:

let
    dwm = pkgs.dwm.overrideAttrs (oldAttrs: {
        src = builtins.fetchGit {
            url = "https://github.com/png670/dwm.git";
            rev = "HEAD";  # Can be a specific commit
        };
    });

    dwmblocks = pkgs.dwmblocks.overrideAttrs (oldAttrs: {
        src = builtins.fetchGit {
            url = "https://github.com/png670/dwmblocks.git";
            rev = "HEAD";
        };
    });

    dmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
        src = builtins.fetchGit {
            url = "https://github.com/png670/dmenu.git";
            rev = "HEAD";
        };
    });

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
