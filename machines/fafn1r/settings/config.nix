# Generic machine configuration and role selection
{
  deviceSettings = {
    type = "laptop";
    headless = false;
    monitors = [
      {
        name = "Virtual-1";
        width = 1920;
        height = 1080;
        workspace = "1";
        primary = true;
      }
    ];  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "fafn1r";
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
