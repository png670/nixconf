{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings;
in
{
  options.systemSettings = {
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Users to create on this system.";
    };

    adminUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Users among systemSettings.users that may administer the machine (wheel).";
    };

    userShell = lib.mkPackageOption pkgs "mksh" { } // {
      description = "Login shell for every user in systemSettings.users.";
    };

    passwordFiles = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = { };
      example = lib.literalExpression ''{ alice = config.sops.secrets."alice-password".path; }'';
      description = ''
        Per-user file holding a hashed password (see mkpasswd). Users without
        an entry keep whatever password was set imperatively with passwd.

        NixOS only applies a password to an existing user when
        users.mutableUsers is false, so setting any entry here makes users
        immutable: passwords changed with passwd are reset on activation.
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = lib.all (user: lib.elem user cfg.users) cfg.adminUsers;
        message = "systemSettings.adminUsers must all be listed in systemSettings.users.";
      }
    ];

    users.mutableUsers = lib.mkIf (cfg.passwordFiles != { }) false;

    users.users = lib.genAttrs cfg.users (user: {
      isNormalUser = true;
      shell = cfg.userShell;
      hashedPasswordFile = cfg.passwordFiles.${user} or null;
      extraGroups = [
        "video"
        "input"
        "render"
      ]
      ++ lib.optional config.networking.networkmanager.enable "networkmanager"
      ++ lib.optional config.services.seatd.enable "seat"
      ++ lib.optional (lib.elem user cfg.adminUsers) "wheel";
    });

    # A login shell has to be listed here to be accepted.
    environment.shells = [ cfg.userShell ];

    # Declares each user to home-manager; what they get comes from
    # home-manager.sharedModules (see flake.nix).
    home-manager.users = lib.genAttrs cfg.users (_: { });
  };
}
