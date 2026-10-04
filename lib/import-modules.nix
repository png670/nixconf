# Every `default.nix` below `dir` (not counting `dir`'s own), as a list of
# paths suitable for `imports`. Adding a module is then just adding a
# directory; there is no import list to keep in sync.
{ lib }:
dir:
lib.filter (path: baseNameOf path == "default.nix" && path != dir + "/default.nix") (
  lib.filesystem.listFilesRecursive dir
)
