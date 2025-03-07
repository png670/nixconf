{
  config,
  inputs,
  ...
}: let
  pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
in {

  gtk.enable = true;

  gtk.theme.package = pkgs.rose-pine-gtk-theme;
  gtk.theme.name = "Rose-pine";


  gtk.iconTheme.package = pkgs.papirus-nord;
  gtk.iconTheme.name = "Papirus";
}
