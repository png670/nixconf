
{
  pkgs,
  config,
  lib,
  ...
}: {

  stylix = {
    base16Scheme = {
      base00 = "#13141d";
      base01 = "#1f1d2e";
      base02 = "#26233a";
      base03 = "#6e6a86";
      base04 = "#908caa";
      base05 = "#e0def4";
      base06 = "#e0def4";
      base07 = "#524f67";
      base08 = "#eb6f92";
      base09 = "#f6c177";
      base0A = "#5E81AC";
      base0B = "#458588";
      base0C = "#9ccfd8";
      base0D = "#c4a7e7";
      base0E = "#f6c177";
      base0F = "#524f67";
    };
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
