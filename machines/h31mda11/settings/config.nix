# Generic machine configuration and role selection
{
  deviceSettings = {
    type = "desktop";
    headless = false;
    monitors = [
      {
        name = "HDMI-A-1";
        width = 1920;
        height = 1080;
        workspace = "1";
        primary = true;
        refreshRate = 74.97;
      }
      {
        name = "HDMI-A-2";
        width = 1920;
        height = 1080;
        workspace = "5";
        rotate_mode = "3";
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
    waybar = "catppuccin";
  };
}
