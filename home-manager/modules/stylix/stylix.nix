
{
  pkgs,
  config,
  lib,
  ...
}: {

  stylix = {
    base16Scheme = {
       base00 = "3C4C55";
       base01 = "556873";
       base02 = "6A7D89";
       base03 = "899BA6";
       base04 = "899BA6";
       base05 = "C5D4DD";
       base06 = "899BA6";
       base07 = "556873";
       base08 = "83AFE5";
       base09 = "7FC1CA";
       base0A = "A8CE93";
       base0B = "7FC1CA";
       base0C = "F2C38F";
       base0D = "83AFE5";
       base0E = "9A93E1";
       base0F = "F2C38F";
#      base00 = "#13141d";
#      base01 = "#303444";
#      base02 = "#434C5E";
#      base03 = "#4C566A";
#      base04 = "#D8DEE9";
#      base05 = "#E5E9F0";
#      base06 = "#ECEFF4";
#      base07 = "#8FBCBB";
#      base08 = "#BF616A";
#      base09 = "#D08770";
#      base0A = "#EBCB8B";
#      base0B = "#A3BE8C";
#      base0C = "#88C0D0";
#      base0D = "#81A1C1";
#      base0E = "#B48EAD";
#      base0F = "#5E81AC";
    };
# 13141d
    image = ./wallpaper.png;

    fonts = {
      monospace = {
        package = pkgs.terminus_font;
        name = "Terminus";
       };
      sansSerif = {
        package = pkgs.libertine;
        name = "Libertine Sans";
       };
      serif = {
        package = pkgs.libertine;
        name = "Libertine Serif";
       };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 10;
        popups = 10;
       };
      };

    # Set the cursor package to Adwaita theme
    cursor.package = pkgs.adwaita-icon-theme;


    opacity = {
      desktop = 0.5;
      terminal = 0.9;
    };

    autoEnable = true;
    enable = true;
  };
}
