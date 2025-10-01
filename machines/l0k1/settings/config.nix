# Generic machine configuration and role selection
{
  deviceSettings = {
    type = "laptop";
    headless = true;
    monitors = [
      {
        name = "HDMI-A-2";
        width = 1920;
        height = 1080;
        workspace = "1";
        primary = true;
      }
    ];  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "l0k1";
    profile = "work";
    locale = "en_ZA.UTF-8";
    timezone = "Africa/Johannesburg";
  };

  userSettings = {
    username = "matthew";
    name = "Matthew";
    email = "matthew.winnan@blahblah.com";
    browser = "qutebrowser";
  };
}
