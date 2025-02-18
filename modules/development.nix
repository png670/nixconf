{lib, pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    imlib2.dev
    mesa
    zlib
    freetype
    gcc
    gnumake
    pkg-config
    stdenv
    gh

  ];
}
