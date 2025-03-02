
{ pkgs, lib, ... }: {

  # Time and Locale settings
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
    # X server and window manager
    xserver.enable = true;
    xserver.windowManager.dwm.enable = true;

    # Display manager and compositor
    displayManager.ly.enable = true;
    picom.enable = true;

    # Sound services
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Bluetooth and other hardware services
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;

    # RTKit for real-time priorities
    security.rtkit.enable = true;
  };

  # Hardware settings
  hardware = {
    enableAllFirmware = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };

  # Programs
  programs = {
    dconf.enable = true;
    direnv.enable = true;
  };

  # XDG portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
