{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.swindle;

  swindle = pkgs.stdenv.mkDerivation {
    pname = "swindle";
    version = "local";

    src = ./source;

    nativeBuildInputs = with pkgs; [ pkg-config wayland-scanner wayland-protocols ];
    buildInputs = with pkgs; [
      wayland
      wlroots_0_20
      pixman
      libxkbcommon
      libinput
      lua5_4
      libxcb
      libxcb-wm
    ];

    enableParallelBuilding = true;

    postPatch = ''
      substituteInPlace Makefile \
        --replace '$(DESTDIR)/etc/swindle' '$(DESTDIR)$(PREFIX)/etc/swindle'
    '';

    makeFlags = [ "PREFIX=${placeholder "out"}" ];

    meta = {
      description = "A dwl fork with Lua configuration, IPC support, and ext-workspace-v1";
      license = with lib.licenses; [ gpl3Only mit isc ];
      platforms = lib.platforms.linux;
      mainProgram = "swindle";
    };
  };

  swindleSession = pkgs.runCommand "swindle-session" {
    passthru.providedSessions = [ "swindle" ];
  } ''
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
  options.systemSettings.swindle.enable =
    lib.mkEnableOption "the swindle Wayland compositor and its session entry";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ swindle swaybg grim wlr-randr slurp ]; # installs both `swindle` and `smsg`
    services.displayManager.sessionPackages = [ swindleSession ];
  };
}
