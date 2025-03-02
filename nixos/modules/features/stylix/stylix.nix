
{
  pkgs,
  config,
  lib,
  ...
}: {

  stylix = {
    base16Scheme = {
      base00 = "#13141d";
      base01 = "#303444";
      base02 = "#434C5E";
      base03 = "#4C566A";
      base04 = "#D8DEE9";
      base05 = "#E5E9F0";
      base06 = "#ECEFF4";
      base07 = "#8FBCBB";
      base08 = "#BF616A";
      base09 = "#D08770";
      base0A = "#EBCB8B";
      base0B = "#A3BE8C";
      base0C = "#88C0D0";
      base0D = "#81A1C1";
      base0E = "#B48EAD";
      base0F = "#5E81AC";
    };
# 13141d
    image = ./wallpaper.png;

    fonts = {
      monospace = {
        package = pkgs.terminus_font;
        name = "Terminus";
       };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
       };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
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
