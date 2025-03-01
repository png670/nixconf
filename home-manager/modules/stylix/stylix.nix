
{
  pkgs,
  config,
  lib,
  ...
}: {

  stylix = {
    base16Scheme = {
      base00 = "#13141d"; # ----
      base01 = "#3B4252"; # ---
      base02 = "#434C5E"; # --
      base03 = "#458588"; # -
      base04 = "#D8DEE9"; # +
      base05 = "#E5E9F0"; # ++
      base06 = "#ECEFF4"; # +++
      base07 = "#8FBCBB"; # ++++
      base08 = "#BF616A"; # red
      base09 = "#D08770"; # orange
      base0A = "#EBCB8B"; # yellow
      base0B = "#A3BE8C"; # green
      base0C = "#88C0D0"; # aqua/cyan
      base0D = "#80a1bd"; # blue
      base0E = "#81A1C1"; # purple
      base0F = "#B48EAD"; # brown
    };

    image = ./wallpaper.png;

    targets.waybar.enable = false;
    targets.rofi.enable = false;
    targets.kde.enable = false;

    opacity = {
      desktop = 0.5;
      terminal = 0.9;
    };

    autoEnable = true;
    enable = true;
  };
}
