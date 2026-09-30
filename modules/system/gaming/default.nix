{ lib, config, pkgs, ... }:

let
  cfg = config.systemSettings.gaming;
in
{
  options.systemSettings.gaming = {
    enable = lib.mkEnableOption "Steam and gaming performance tweaks";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "steam" "steam-unwrapped" "steam-jupiter-unwrapped" ];

    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
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
      };
    };

    programs.steam = {
      enable = true;
      extest.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
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
      steam
      gamemode
      prismlauncher
      protonup-qt
    ];

    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.gamescope.capSysNice = false;

    # Used by some LAN co-op games.
    networking.firewall.allowedTCPPorts = [ 24872 ];
    networking.firewall.allowedUDPPorts = [ 24872 ];
  };
}
