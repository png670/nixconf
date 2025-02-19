
{ lib, ... }:

{
  home.file = {
    ".config/dwm" = {
      source = ../../../../../.config/dwm;
      target = ".config/dwm";  # This is usually where DWM looks for its config
      recursive = true;  # This allows copying the entire directory structure
    };
  };
}
