{
  description = "A collection of helper functions usable across my different personal projects.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs.lib) genAttrs removeSuffix mapAttrs' nameValuePair;
    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    legacyPackages = genAttrs allSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsSelf = self.legacyPackages.${system};
      readDirImportable = import ./bootstrap/read-dir-importable.nix {inherit (pkgs) lib;};
      callPackagesInDirectory = import ./bootstrap/call-packages-in-directory.nix {
        inherit readDirImportable;
        inherit (pkgs) callPackage;
      };
      toCamelCase = import ./bootstrap/to-camel-case.nix {inherit (pkgs) lib;};
      correctName = name: (toCamelCase (removeSuffix ".nix" name));
      boostrapPackages = {inherit readDirImportable callPackagesInDirectory toCamelCase;};
      pkgsDir = callPackagesInDirectory ./. (pkgsSelf // boostrapPackages);
      correctedPkgsDir = mapAttrs' (name: value: nameValuePair (correctName name) value) pkgsDir;
    in
      boostrapPackages // correctedPkgsDir);

    formatter = genAttrs allSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  in {inherit formatter legacyPackages;};
}
