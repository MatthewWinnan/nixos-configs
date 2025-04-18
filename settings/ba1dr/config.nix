{
  deviceSettings = {
    type = "laptop";
    monitors = [
      {
        name = "HDMI-A-1";
        width = 1920;
        height = 1080;
        workspace = "1";
        primary = true;
      }
    ];
  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "ba1dr";
    profile = "gaming";
    locale = "en_ZA.UTF-8";
    timezone = "Africa/Johannesburg";
  };

  userSettings = {
    username = "matthew";
    name = "Matthew";
    email = "mcwinnan@gmail.com";
  };
}
