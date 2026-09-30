{ pkgs, ... }:

{
  systemSettings = {
    users = [ "png76" ];
    adminUsers = [ "png76" ];
    gaming.enable = true;
    bluetooth.enable = false;
    flatpak.enable = true;
    swindle.enable = true;

    security = {
      does.enable = true;
      firewall.enable = true;
      gpg.enable = true;
      openvpn.enable = false;
      sshd.enable = false;
    };
  };

  users.users.png76 = {
    description = "png76";
    shell = pkgs.mksh;
  };

  system.stateVersion = "26.05";
}
