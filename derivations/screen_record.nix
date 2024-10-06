{pkgs, lib, ...}:
pkgs.writeTextFile {
  name = "screen_recording";
  text = ''
  #!${lib.getExe pkgs.fish}

  # Set the path for wf-recorder and slurp
  set wf_recorder "${lib.getExe pkgs.wf-recorder}"
  set slurp "${lib.getExe pkgs.slurp}"
  set current_date (date +%Y-%m-%d_%H:%M:%S)

  # Record screen area selected by slurp and save it to the Recordings directory
  $wf_recorder -a -g ( $slurp -w 0 -d ) -f "$HOME/Recordings/$current_date.mp4"
  '';
  executable = true;
  destination = "/bin/screen_recording";
}


