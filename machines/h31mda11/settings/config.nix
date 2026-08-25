# Generic machine configuration and role selection
{
  deviceSettings = {
    type = "desktop";
    headless = false;
    greeter = "regreet";
    monitors = [
      {
        name = "DP-1";
        width = 3440;
        height = 1440;
        workspace = "1";
        primary = true;
        refreshRate = 180.08;
        # Map SDR across the panel's usable luminance range instead of
        # Hyprland's 80 nit default, which squashed the desktop into the bottom
        # fifth of a 400 nit panel and looked washed out. Min is the EDID floor
        # for this display (VIE WV34QHDV80); max is held just under its 277 nit
        # sustained frame-average rather than its 400 nit peak, which the
        # backlight can only hit on small highlights and would otherwise dim
        # back down under ABL on bright screens.
        cm = "hdr";
        sdr_min_luminance = 0.125;
        sdr_max_luminance = 250;
        bitdepth = 10;
      }
      {
        name = "HDMI-A-2";
        width = 1920;
        height = 1080;
        workspace = "5";
        rotate_mode = "1";
        position = "-1080x0";
        refreshRate = 100.00;
      }
    ];
  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "h31mda11";
    profile = "gaming";
    locale = "en_ZA.UTF-8";
    timezone = "Africa/Johannesburg";
  };

  userSettings = {
    username = "matthew";
    name = "Matthew";
    email = "mcwinnan@gmail.com";
    browser = "qutebrowser";
    waybar = "omarchy";
    shell = "fish";
    terminal = "wezterm";
  };
}
