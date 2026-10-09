{ config, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    secrets = {
      "tailscale-authkey" = { };
      "irc-password".owner = "png76"; # read by senpai
      "png76-password".neededForUsers = true;
    };
  };

  systemSettings = {
    users = [ "png76" ];
    adminUsers = [ "png76" ];
    passwordFiles.png76 = config.sops.secrets."png76-password".path;
    desktopApps.enable = true;
    gaming = {
      enable = true;
      openPorts = [ 24872 ]; # LAN co-op
    };
    bluetooth.enable = false;
    flatpak.enable = true;
    swindle.enable = true;
    graphics.enable = true;
    audio.enable = true;
    networkManager.enable = true;
    syncthing.openFirewall = true;

    security = {
      doas.enable = true;
      gpg.enable = true;
      openvpn.enable = false;
      sshd = {
        enable = true;
        openOn = [ "tailscale0" ];
      };
      automount.enable = true;
      tailscale = {
        enable = true;
        authKeyFile = config.sops.secrets."tailscale-authkey".path;
      };
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "i2c-dev" ];

  system.stateVersion = "26.05";
}
