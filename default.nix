{
  pkgs,
  pkgsSelf,
  lib,
  ...
}: let
  readDirImportable = import ./bootstrap/read-dir-importable.nix {inherit lib;};
  callPackagesInDirectory = import ./bootstrap/call-packages-in-directory.nix {
    inherit readDirImportable;
    inherit (pkgs) callPackage;
  };
in
  callPackagesInDirectory ./. pkgsSelf
