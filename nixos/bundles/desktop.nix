
{ pkgs, lib, user, ... }: {

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  services = {
    xserver.enable = true;
    xserver.windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "png670";
          repo = "dwm";
          rev = "7257b01068ea908ce89017504f677d3cb49d54fc";
          hash = "sha256-sHDX8dRb32Qv4NRt48tt8JlPd/XLr6fo0pKtS/hyt8A=";
        };
      });
    };
    displayManager.ly.enable = true;
    picom.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  security.rtkit.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  programs = {
    dconf.enable = true;
    direnv.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

}
