{ pkgs, ... }:

{
  systemSettings = {
    users = [ "png76" ];
    adminUsers = [ "png76" ];

    monitoring.enable = true;
    performance.enable = true;

    security = {
      doas.enable = true;
      sshd.enable = true;

      router = {
        enable = true;
        wanInterface = "end0"; 
        lanInterface = "wlan0"; 
      };

      accessPoint = {
        enable = true;
        interface = "wlan0";
        ssid = "ML6661458";
        passwordFile = "/etc/secrets/pass";
      };
    };
  };

  services.openssh.openFirewall = false;

  users.users.png76 = {
    description = "png76";
    shell = pkgs.mksh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICEFoA1Wtp+Z+sN/ltu4DSKCZxa4GS8C07DqHVZb+wex png76@snow"
    ];
  };

  boot.loader.efi.canTouchEfiVariables = false;

  hardware.enableRedistributableFirmware = true;

  # — interfaces are addressed declaratively by the router module instead,
  # so the legacy global DHCP client shouldn't also be racing for them.
  networking.useDHCP = false;

  system.stateVersion = "26.05";
}
