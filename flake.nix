{
  description = "Generic helpers usable across my different personal projects.";

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
    legacyPackages = genAttrs allSystems (system:
      import ./lib {
        pkgs = nixpkgs.legacyPackages.${system};
        pkgsSelf = self.legacyPackages.${system};
      });
    formatter = genAttrs allSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    defaultPackage = genAttrs allSystems (system: self.legacyPackages.${system}.lib);
  in {inherit formatter legacyPackages defaultPackage;};
}
