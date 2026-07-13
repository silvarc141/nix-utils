# writeNuBin that allows to specify plugins
# WARNING: untested
{
  lib,
  pkgs,
  makeScriptWriter,
  nushell,
  ...
}:
name: argsOrScript:
let
  inherit (lib)
    isAttrs
    isDerivation
    optionals
    makeBinPath
    getExe
    ;

  argCheck = isAttrs argsOrScript && !isDerivation argsOrScript;
  allArgs = if argCheck then argsOrScript else { };
  script = if argCheck then null else argsOrScript;

  plugins = allArgs.plugins or [ ];
  pluginPath = optionals (plugins != [ ]) [
    "--prefix"
    "PATH"
    ":"
    "${makeBinPath plugins}"
  ];

  conf = (builtins.removeAttrs allArgs [ "plugins" ]) // {
    interpreter = "${getExe nushell} --no-config-file --stdin";
    makeWrapperArgs = (allArgs.makeWrapperArgs or [ ]) ++ pluginPath;
  };

  writer = makeScriptWriter conf name;
in
if script == null then writer else writer script
