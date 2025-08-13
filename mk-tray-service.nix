{lib, ...}: {
  command,
  description,
  settings ? {},
}: (lib.recursiveUpdate {
    Unit = {
      Description = description;
      Requires = ["tray.target"];
      After = ["graphical-session.target" "tray.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = command;
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  }
  settings)
