{ lib, ... }:

let
  entries = builtins.readDir ./.;
  subdirNames = builtins.attrNames (lib.filterAttrs (_: type: type == "directory") entries);
  modulePath = name: ./. + "/${name}/default.nix";
in
{
  imports = map modulePath (builtins.filter (name: builtins.pathExists (modulePath name)) subdirNames);
}
