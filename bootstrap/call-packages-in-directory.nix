{
  callPackage,
  readDirImportable,
}: directory: dependencies: let
  paths = builtins.attrNames (readDirImportable directory);
  mkOutput = path: {
    name = path;
    value = callPackage "${directory}/${path}" dependencies;
  };
in
  builtins.listToAttrs (map mkOutput paths)
