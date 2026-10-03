{ config, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    secrets."tailscale-authkey" = { };
  };

  systemSettings = {
    users = [ "png76" ];
    adminUsers = [ "png76" ];
    gaming.enable = true;
    bluetooth.enable = false;
    flatpak.enable = true;
    swindle.enable = true;
    graphics.enable = true;
    audio.enable = true;
    networkManager.enable = true;

    security = {
      doas.enable = true;
      firewall.enable = true;
      gpg.enable = true;
      openvpn.enable = false;
      sshd.enable = true;
      automount.enable = true;
      tailscale = {
        enable = true;
        authKeyFile = config.sops.secrets."tailscale-authkey".path;
      };
    };
  };

  users.users.png76 = {
    description = "png76";
    shell = pkgs.mksh;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "i2c-dev" ];

  system.stateVersion = "26.05";
}
