{lib, readDirImportable, ...}: pathToDir: map (path: lib.strings.removeSuffix ".nix" path) (lib.attrNames (readDirImportable pathToDir))
