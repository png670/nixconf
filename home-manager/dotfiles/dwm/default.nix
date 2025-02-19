{ lib, config, ... }:

{
  home.file.".config/dwm/config.h".source =
    config.lib.file.mkOutOfStoreSymlink ./config.h;
}
