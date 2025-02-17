# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

services.xserver.enable = true;
services.xserver.windowManager.dwm.enable = true;
services.tlp.enable = true;
services.displayManager.ly.enable = true;
services.picom.enable = true;

programs.zsh.enable = true;
nixpkgs.config.allowUnfree = true;


nix.settings.experimental-features = [ "nix-command" "flakes" ];

users.extraUsers.png76 = {
  shell = pkgs.zsh;
};

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.png76 = {
    isNormalUser = true;
    description = "png76";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox

    ];
  };



  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  qt5.qtbase
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

nixpkgs.overlays = [
  (final: prev: {
    dwm = prev.dwm.overrideAttrs (old: { src = ./suckless/dwm; });
    dmenu = prev.dmenu.overrideAttrs (old: { src = ./suckless/dmenu; });
    dwmblocks = prev.dwmblocks.overrideAttrs (old: { src = ./suckless/dwmblocks; });
  })
];


environment.etc."xdg/dunst/dunstrc".source = "/home/png76/.config/dunst/dunstrc";



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # Did you read the comment?
  system.stateVersion = "23.05";
}
