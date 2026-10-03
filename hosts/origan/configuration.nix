{ config, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    secrets = {
      "wifi-pass" = { };
      "cloudflare-env" = { };
      "tailscale-authkey" = { };
    };
  };

  systemSettings = {
    users = [ "png76" ];
    adminUsers = [ "png76" ];

    monitoring.enable = true;
    performance.enable = true;

    security = {
      doas.enable = true;
      sshd = {
        enable = true;
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
          zoneDomain = "png76.xyz";
          hostName = "home.png76.xyz";
          acmeEmail = "jglaf7uoe@mozmail.com";
          cloudflareEnvFile = config.sops.secrets."cloudflare-env".path;
        };
      };

      tailscale = {
        enable = true;
        advertiseLanRoutes = true;
        authKeyFile = config.sops.secrets."tailscale-authkey".path;
      };
    };
  };

  services.openssh.openFirewall = false;

  services.hostapd.radios.wlan0.wifi5.operatingChannelWidth = "20or40";

  users.users.png76 = {
    description = "png76";
    shell = pkgs.mksh;
  };

  boot.loader.efi.canTouchEfiVariables = false;

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.raspberrypiWirelessFirmware ];

  # — interfaces are addressed declaratively by the router module instead,
  # so the legacy global DHCP client shouldn't also be racing for them.
  networking.useDHCP = false;
  networking.enableIPv6 = false;

  system.stateVersion = "26.05";
}
