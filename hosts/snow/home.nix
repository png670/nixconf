{ ... }:

{
  userSettings = {
    foot.enable = true;
    mako.enable = true;
    neovim.enable = true;
    ranger.enable = true;
    rofi.enable = true;
    waybar.enable = true;
    git.enable = true;

    senpai = {
      enable = true;
      address = "home.png76.xyz:6697";
      nick = "png76";
      passwordCommand = [ "cat" "/home/png76/.config/pass" ];
    };
  };

  home.stateVersion = "26.05";
}
