{
  lib,
  runCommand,
  nushell,
}:
name: env: script:
runCommand name (
  env
  // {
    nativeBuildInputs = (env.nativeBuildInputs or [ ]) ++ [ nushell ];
  }
) "nu -c ${lib.escapeShellArg script}"
