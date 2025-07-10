{pkgs, pkgsSelf, ...}: {
  lib = {
    readDirImportable = import ./read-dir-importable.nix {inherit pkgs pkgsSelf;};
    writeNuScriptBin = import ./write-nu-script-bin.nix {inherit pkgs pkgsSelf;};
    runCommandNu = import ./run-command-nu.nix {inherit pkgs pkgsSelf;};
    callPackagesInDirectory = import ./call-packages-in-directory.nix {inherit pkgs pkgsSelf;};
  };
}
