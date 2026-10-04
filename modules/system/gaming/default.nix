{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.systemSettings.gaming;
in
{
  options.systemSettings.gaming = {
    enable = lib.mkEnableOption "Steam and gaming performance tweaks";

    openPorts = lib.mkOption {
      type = lib.types.listOf lib.types.port;
      default = [ ];
      example = [ 24872 ];
      description = "TCP and UDP ports to open on every interface, for LAN co-op games.";
    };

    hostDedicatedServers = lib.mkEnableOption "opening the firewall for Source dedicated servers";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      extest.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = cfg.hostDedicatedServers;

      extraPackages = with pkgs; [
        libxcursor
        libxi
        libxinerama
        libxscrnsaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        gamemode
      ];

      gamescopeSession = {
        enable = true;
        env = {
          WLR_RENDERER = "vulkan";
          DXVK_HDR = "1";
          ENABLE_GAMESCOPE_WSI = "1";
          ENABLE_HDR_WSI = "1";
          WINE_FULLSCREEN_FSR = "1";
        };
        args = [
          "--xwayland-count 1"
          "-e" # Enable Steam integration
          "--adaptive-sync"
          "--hdr-enabled"
          "--hdr-itm-enable"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      prismlauncher
      protonup-qt
    ];

    programs.gamemode.enable = true;
    programs.gamescope = {
      enable = true;
      capSysNice = false;
    };

    networking.firewall = {
      allowedTCPPorts = cfg.openPorts;
      allowedUDPPorts = cfg.openPorts;
    };
  };
}
