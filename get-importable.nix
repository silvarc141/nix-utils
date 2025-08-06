{readDirImportable}: pathToDir: map (x: "${pathToDir}/${x}") (builtins.attrNames (readDirImportable pathToDir))
