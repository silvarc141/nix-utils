{
  description = "Generic helper functions usable across my different personal projects.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs.lib) genAttrs;
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
    in
      {inherit readDirImportable callPackagesInDirectory;} // callPackagesInDirectory ./. pkgsSelf);
    formatter = genAttrs allSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  in {inherit formatter legacyPackages;};
}
