{
  config,
  inputs,
  ...
}: let
  pkgs = inputs.nixpkgsold.legacyPackages."x86_64-linux";
in {

  gtk.enable = true;
  gtk.iconTheme.package = pkgs.papirus-nord;
  gtk.iconTheme.name = "Papirus-Nord";
}
