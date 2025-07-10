{pkgs, ...}: {
  lib = {
    readDirImportable = import ./read-dir-importable.nix {inherit pkgs;};
    writeNuScriptBin = import ./write-nu-script-bin.nix {inherit pkgs;};
    runCommandNu = import ./run-command-nu.nix {inherit pkgs;};
  };
}
