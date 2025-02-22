

{ lib, config, ... }:

{
  home.file = {
    "./dmenu/config.def.h" = {
      source = "/home/png76/.config/dmenu/config.def.h";
    };

    "./dwmblocks/config.h" = {
      source = "/home/png76/.config/dwmblocks/config.h";
    };

    "./dwm/.config.h" = {
      source = "/home/png76/.config/dwm/config.h";
    };
  };
}
