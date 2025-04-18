{
  deviceSettings = {
    type = "laptop";
    monitors = [
      {
        name = "HDMI-A-2";
        width = 1920;
        height = 1080;
        workspace = "1";
        primary = true;
      }
    ];
  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "th0r";
    profile = "personal";
    locale = "en_ZA.UTF-8";
    timezone = "Africa/Johannesburg";
  };

  userSettings = {
    username = "h3rm3s";
    name = "Matthew";
    email = "mcwinnan@gmail.com";
  };
}
