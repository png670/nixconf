{ config, lib, pkgs, ... }:

{
  options.systemSettings = {
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Desktop users to create on this system.";
    };
    adminUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Users among systemSettings.users granted wheel (sudo) access.";
    };
  };

  config = {
    users.users = builtins.listToAttrs (map
      (user: {
        name = user;
        value = {
          isNormalUser = true;
          createHome = true;
          extraGroups = [ "networkmanager" "video" "input" "seat" "render" ]
            ++ lib.optional (builtins.elem user config.systemSettings.adminUsers) "wheel";
        };
      })
      config.systemSettings.users);

    # Any shell a user is set to needs to be listed here, or it won't be
    # accepted as a login shell.
    environment.shells = [ pkgs.mksh ];

    home-manager.users = builtins.listToAttrs (map
      (user: {
        name = user;
        value = {
          home.username = user;
          home.homeDirectory = "/home/${user}";
        };
      })
      config.systemSettings.users);
  };
}
