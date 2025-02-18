{ config, lib, pkgs, vars, ... }:

with lib;
{
  options = {
    dwm = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.dwm.enable) {
    services = {
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = false;
        };
      };
      displayManager = {
        defaultSession = "none+dwm";
      };
      xserver = {
        enable = true;
        autorun = true;
        displayManager = {
          startx.enable = true;
        };
        windowManager.dwm = {
          enable = true;
          package = pkgs.dwm.overrideAttrs {
            src = pkgs.fetchFromGitHub {
              owner = "png670";
              repo = "dwm";
              rev = "main";
              sha256 = "sha256-BS0TqbPZwDoh/qx2MgTnpM3rFcRC2R4e0/TssFPuTxA=";
              # sha256 = lib.fakeSha256;
            };
          };
        };

      };
    };

    environment = {
      loginShellInit = ''
        # Start graphical server on user's current tty if not already running.
        [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC" &> /dev/null
      '';
    };

    environment = {
      systemPackages = with pkgs; [
	slstatus
      ];
    };
  };
}
