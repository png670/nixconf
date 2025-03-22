
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
    displayManager.ly.enable = true;
    xserver.displayManager.startx.enable = true;
    picom.enable = true;
    udisks2.enable = true;
    dbus.enable = true;
    flatpak.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  security = {
     rtkit.enable = true;
     polkit.enable = true;

  };

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

  ## Packages

  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    lf
    wget
    xclip
    udiskie
    zsh
    tmux
    alsa-utils
    pamixer
    htop
    nh
    neofetch
    neovim
    mesa
    zlib
    freetype
    sxiv
    mpv
    prismlauncher
    flameshot
    brightnessctl
    dunst
    picom
    kitty
    lm_sensors
    xorg.xkill
    libnotify
    gnome-system-monitor
    nix-prefetch-git

    #suckless
    st
    dunst
    slock

  ];
  fonts.packages = with pkgs; [
    hack-font
    cm_unicode
    terminus_font
    libertinus
  ];
}
