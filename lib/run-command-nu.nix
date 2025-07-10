{pkgs, pkgsSelf}: name: env: buildCommand: let
  lib = pkgs.lib;
  mkEnvLine = name: value: ''$env.${name} = "${value}"'';
  script = pkgs.writeText "nu-script" ''
    let out = $env.out
    ${lib.concatLines (lib.mapAttrsToList mkEnvLine env)}
    ${buildCommand}
  '';
in
  pkgs.runCommand name env ''${pkgs.nushell}/bin/nu ${script}''
