{
  config,
  inputs,
  ...
}: let
  pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
in {

  gtk.enable = true;

  gtk.theme.package = pkgs.rose-pine-gtk-theme;
  gtk.theme.name = "rose-pine";


  gtk.iconTheme.package = pkgs.rose-pine-icon-theme;
  gtk.iconTheme.name = "rose-pine";

  gtk.cursorTheme.package = pkgs.adwaita-icon-theme;
  gtk.cursorTheme.name =  "Adwaita";
  gtk.cursorTheme.size = 1; # Adjust size if needed
}
