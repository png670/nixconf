

{ lib, config, ... }:

{
  home.file = {
    ".config/dwm" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/png76/.config/dwm";
    };

    ".config/dwmblocks" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/png76/.config/dwmblocks";
    };

    ".config/dmenu" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/png76/.config/dmenu";
    };
  };
}
