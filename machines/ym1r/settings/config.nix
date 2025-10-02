# Generic machine configuration and role selection
{
  deviceSettings = {
    type = "laptop";
    headless = false;
    monitors = [];  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "ym1r";
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
