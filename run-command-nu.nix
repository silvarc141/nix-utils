{
  lib,
  writeText,
  nushell,
  runCommand,
  ...
}: name: env: buildCommand: let
  mkEnvLine = name: value: ''$env.${name} = "${value}"'';
  script = writeText "nu-script" ''
    let out = $env.out
    ${lib.concatLines (lib.mapAttrsToList mkEnvLine env)}
    ${buildCommand}
  '';
in
  runCommand name env ''${nushell}/bin/nu ${script}''
