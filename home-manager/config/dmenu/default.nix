{ lib, config, ... }:

{
  home.file.".config/dmenu/config.def.h".source =
    config.lib.file.mkOutOfStoreSymlink ./config.def.h;
}
