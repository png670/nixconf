{ lib }:
dir:
lib.filter (path: baseNameOf path == "default.nix" && path != dir + "/default.nix") (
  lib.filesystem.listFilesRecursive dir
)
