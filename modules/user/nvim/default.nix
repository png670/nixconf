{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.neovim;
in
{
  options.userSettings.neovim.enable = lib.mkEnableOption "neovim config";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
      curl
      git
      ripgrep
      wl-clipboard
    ];

    xdg.configFile."nvim/init.lua".source = ./config/init.lua;
    xdg.configFile."nvim/lua".source = ./config/lua;
  };
}
