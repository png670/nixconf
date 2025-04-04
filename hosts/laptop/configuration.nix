
{ config, pkgs, lib, user, outputs, myLib, ... }:

{
  imports = [
    ./hardware-configuration.nix

    outputs.nixosModules.default
  ];

  ## System Settings
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

  nixpkgs.config.allowUnfree = true;

  ## Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  ## Nix Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = builtins.readFile /home/png76/.config/xmonad/xmonad.hs;
  };

#  displayManager = { defaultSession = "none+xmonad"; };

  ## Services
  services = {
    displayManager.ly.enable = true;
    displayManager = { defaultSession = "none+xmonad"; };
    xserver.enable = true;
    xserver.displayManager.startx.enable = true;
    xserver.xkb = { # Keyboard Layout
      layout = "gb";
      variant = "";
    };

    picom.enable = true;
    udisks2.enable = true;
    dbus.enable = true;
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

  ## Console Settings
  console = {
    useXkbConfig = true;
    earlySetup = true;  # Required for GRUB
  };

  ## Hardware Acceleration
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  ## Programs
  programs = {
    dconf.enable = true;
    direnv.enable = true;
    zsh.enable = true;
    nix-ld.enable = true;
  };

  ## XDG Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  ## User Configuration
  users.users.png76 = {
    isNormalUser = true;
    description = "png76";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;  # Default shell
  };

  ## System Packages
  environment.systemPackages = with pkgs; [
    thunderbird
    lf
    wget
    xclip
    udiskie
    zsh
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
    (prismlauncher.override { jdks = [ jdk21 ]; })
    flameshot
    brightnessctl
    dunst
    picom
    kitty
    lm_sensors

    xorg.xkill
    xorg.xauth
    xorg.libX11
    libnotify

    xmobar

    obsidian
    nix-prefetch-git

    dmenu
    dunst
    slock
  ];

  ## Fonts
  fonts.packages = with pkgs; [
    font-awesome
    iosevka
#    hack-font
    terminus_font
    libertinus
  ];

  ## System Version (Do not modify)
  system.stateVersion = "23.05";
}
