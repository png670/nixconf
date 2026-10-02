{ pkgs, ... }:

{
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
        passwordFile = "/etc/secrets/pass";
      };
    };
  };

  services.openssh.openFirewall = false;

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

  system.stateVersion = "26.05";
}
