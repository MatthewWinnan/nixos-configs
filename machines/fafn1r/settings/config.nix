# Generic machine configuration and role selection
# Location is read from .profile file (written by `just profile`), defaults to "work"
# This controls monitor layout and network-dependent settings (caches, certs)
let
  profilePath = ./. + "/.profile";
  activeLocation =
    if builtins.pathExists profilePath
    then builtins.replaceStrings ["\n" " "] ["" ""] (builtins.readFile profilePath)
    else "work";

  # Monitor configurations per location
  monitorProfiles = {
    work = [
      {
        name = "Virtual-1";
        width = 1920;
        height = 1080;
        workspace = "1";
        primary = true;
      }
    ];
    home = [
      # TODO: Replace with your home monitor config
      {
        name = "Virtual-1";
        width = 2560;
        height = 1440;
        workspace = "1";
        primary = true;
      }
    ];
  };
in
{
  deviceSettings = {
    type = "vm";
    headless = false;
    monitors = monitorProfiles.${activeLocation};
    # Expose location so other modules can key off it
    location = activeLocation;
  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "fafn1r";
    profile = "work";
    locale = "en_ZA.UTF-8";
    timezone = "Africa/Johannesburg";
  };

  userSettings = {
    username = "matthew";
    name = "Matthew Winnan";
    email = "placeholder@example.com"; # overridden at runtime by sops secret
    browser = "qutebrowser";
    waybar = "omarchy";
    shell = "fish";
    terminal = "wezterm";
  };
}
