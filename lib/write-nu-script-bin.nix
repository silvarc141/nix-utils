{pkgs}: name: text:
pkgs.writeTextFile {
  inherit name;
  executable = true;
  destination = "/bin/${name}";
  text = ''
    #!${pkgs.nushell}/bin/nu --stdin
    ${text}
  '';
  meta.mainProgram = name;
}
