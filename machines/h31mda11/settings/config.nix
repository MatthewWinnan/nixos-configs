# Generic machine configuration and role selection
{
  deviceSettings = {
    type = "desktop";
    headless = false;
    monitors = [
      {
        name = "HDMI-1";
        width = 1920;
        height = 1080;
        workspace = "1";
        primary = true;
      }
	{
        name = "HDMI-2";
        width = 1080;
        height = 1920;
        workspace = "2";
	rotate_mode = "5";
        position = "-1080x0";
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
  };
}
