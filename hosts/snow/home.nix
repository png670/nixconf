{ inputs, osConfig, ... }:

let
  bouncer = inputs.self.nixosConfigurations.origan.config.systemSettings.security.bouncer.remote;
in
{
  userSettings = {
    foot.enable = true;
    mako = {
      enable = true;
      output = "DP-2";
    };
    neovim.enable = true;
    ranger.enable = true;
    rofi.enable = true;
    waybar.enable = true;
    git.enable = true;
    swindle.enable = true;

    senpai = {
      enable = true;
      address = "${bouncer.hostName}:${toString bouncer.port}";
      nick = "png76";
      passwordFile = osConfig.sops.secrets."irc-password".path;
    };
  };

  home.stateVersion = "26.05";
}
