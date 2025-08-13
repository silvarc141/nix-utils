{
  lib,
  writeScriptBin,
  nushell,
  runCommand,
  makeWrapper,
  ...
}: {
  name,
  text,
  plugins ? [],
}: let
  nuWithPlugins =
    runCommand "${name}-nu-wrapper" {
      nativeBuildInputs = [nushell makeWrapper];
    } ''
      makeWrapper ${nushell}/bin/nu $out/bin/nu --prefix PATH : ${lib.makeBinPath plugins}
    '';
in
  writeScriptBin name ''
    #!${nuWithPlugins}/bin/nu --stdin
    ${text}
  ''
