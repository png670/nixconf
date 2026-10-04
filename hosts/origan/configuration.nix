{ config, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    secrets = {
      "wifi-pass" = { };
      "cloudflare-env" = { };
      "cloudflare-ddns-token" = { };
      "tailscale-authkey" = { };
      "png76-password".neededForUsers = true; 
    };
  };

  systemSettings = {
    users = [ "png76" ];
    adminUsers = [ "png76" ];
    passwordFiles.png76 = config.sops.secrets."png76-password".path;

    monitoring.enable = true;
    performance.enable = true;

    security = {
      doas.enable = true;
      sshd = {
        enable = true;
        openOn = [
          config.systemSettings.security.router.lanInterface
          "tailscale0"
        ];
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICEFoA1Wtp+Z+sN/ltu4DSKCZxa4GS8C07DqHVZb+wex png76@snow"
        ];
      };

      router = {
        enable = true;
        wanInterface = "enabcm6e4ei0";
        lanInterface = "wlan0";
      };

      accessPoint = {
        enable = true;
        interface = "wlan0";
        ssid = "origan";
        passwordFile = config.sops.secrets."wifi-pass".path;
        band = "5g";
        channel = 36;
      };

      bouncer = {
        enable = true;
        remote = {
          enable = true;
          hostName = "home.png76.xyz";
          acmeEmail = "jglaf7uoe@mozmail.com";
          acmeCredentialsFile = config.sops.secrets."cloudflare-env".path;
          ddnsTokenFile = config.sops.secrets."cloudflare-ddns-token".path;
        };
      };

      tailscale = {
        enable = true;
        advertiseLanRoutes = true;
        authKeyFile = config.sops.secrets."tailscale-authkey".path;
      };
    };
  };

  services.hostapd.radios.wlan0.wifi5.operatingChannelWidth = "20or40";

  boot.loader.efi.canTouchEfiVariables = false;

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.raspberrypiWirelessFirmware ];

  # The router module addresses the interfaces declaratively, so the global
  # DHCP client must not race it for them.
  networking.useDHCP = false;
  networking.enableIPv6 = false;

  system.stateVersion = "26.05";
}
