{ config, lib, pkgs, ... }:

let
  cfg = config.userSettings.git;
in
{
  options.userSettings.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gh ];
    programs.git = {
      enable = true;
      userName = "png670";
      userEmail = "png6760@gmail.com";

      lfs.enable = true;

      extraConfig = {
        init.defaultBranch = "main";
	# other things
      };
    };

    services.ssh-agent.enable = true;
  };
}
