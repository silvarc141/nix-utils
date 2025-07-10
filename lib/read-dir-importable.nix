{pkgs, pkgsSelf}: pathToDir: let
  inherit (pkgs.lib) filterAttrs;
  forbiddenFileNames = [
    "default.nix"
    "shell.nix"
    "flake.nix"
  ];
  paths = builtins.readDir pathToDir;
  importableDirectories = filterAttrs (n: v: (v == "directory") && builtins.pathExists (pathToDir + "/${n}/default.nix")) paths;
  importableFiles =
    filterAttrs (
      n: v:
        (v == "regular")
        && (builtins.match ".*\\.nix" n) != null
        && (builtins.all (x: n != x) forbiddenFileNames)
    )
    paths;
in
  importableDirectories // importableFiles
