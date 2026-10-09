{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.git;
in
{
  options.userSettings.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        user.name = "png670";
        user.email = "png6760@gmail.com";

        init.defaultBranch = "main";
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    services.ssh-agent.enable = true;
  };
}
