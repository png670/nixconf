{pkgs, lib, config, ... }:
{

  programs={
    steam.enable = true;
  };

  environment.systemPackages = with pkgs; [
      steam-run
      prismlauncher
      qbittorrent
  ];

}
