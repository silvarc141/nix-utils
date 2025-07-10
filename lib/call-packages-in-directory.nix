{pkgs, pkgsSelf}:directory: dependencies: let
  paths = builtins.attrNames (pkgsSelf.lib.readDirImportable directory);
  mkOutput = path: {
    name = path;
    value = pkgs.callPackage "${directory}/${path}" dependencies;
  };
in
  builtins.listToAttrs (map mkOutput paths)
