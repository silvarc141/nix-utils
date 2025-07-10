{
  writeTextFile,
  nushell,
  ...
}: name: text:
writeTextFile {
  inherit name;
  executable = true;
  destination = "/bin/${name}";
  text = ''
    #!${nushell}/bin/nu --stdin
    ${text}
  '';
  meta.mainProgram = name;
}
