{ lib, config, ... }:

{
  home.file.".config/dwmblocks/config.h".source =
    config.lib.file.mkOutOfStoreSymlink ./config.h;
}
