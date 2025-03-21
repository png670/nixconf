
{ config, pkgs, ... }: {
  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };
  };
}
