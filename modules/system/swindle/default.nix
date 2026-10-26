{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.systemSettings.swindle;

  swindle = inputs.swindle.packages.${pkgs.stdenv.hostPlatform.system}.default;

  swindleSession =
    pkgs.runCommand "swindle-session"
      {
        passthru.providedSessions = [ "swindle" ];
      }
      ''
        mkdir -p $out/share/wayland-sessions
        cat > $out/share/wayland-sessions/swindle.desktop <<EOF
        [Desktop Entry]
        Name=Swindle
        Comment=dwl fork with Lua configuration
        Exec=${swindle}/bin/swindle
        Type=Application
        EOF
      '';
in
{
  options.systemSettings.swindle.enable = lib.mkEnableOption "the swindle Wayland compositor and its session entry";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swindle 
      swaybg
      grim
      wlr-randr
      slurp
    ];
    services.displayManager.sessionPackages = [ swindleSession ];

    programs.xwayland.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = [
        "wlr"
        "gtk"
      ];
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # electron/chromium on wayland
  };
}
