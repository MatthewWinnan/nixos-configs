# Generic machine configuration and role selection
# Location-specific settings (monitors, caches, certs) are handled via
# NixOS specialisations — both "work" and "home" are built simultaneously
# and selectable at boot or via `just fafnir-switch <profile>`.
{
  deviceSettings = {
    type = "vm";
    headless = false;
    # Default monitors (work) — overridden by specialisations
    monitors = [
      {
        name = "Virtual-1";
        width = 1920;
        height = 1080;
        workspace = "1";
        primary = true;
        refreshRate = 60.00;
      }
    ];
    # Default location — overridden by specialisations
    location = "work";
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
