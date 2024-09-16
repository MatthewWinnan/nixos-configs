{

deviceSettings = {
    type = "work";
    monitors = [
      {
      name = "DP-4";
      width = 1920;
      height = 1080;
      workspace = "1";
      primary = true;
      position = "0x0";
      }
      {
      name = "HDMI-A-2";
      width = 1024;
      height = 768;
      workspace = "7";
        primary = false;
        position = "-1024x0";
      }
      {
      name = "DP-3";
      width = 1280;
      height = 1024;
      workspace = "5";
        primary = false;
        position = "1920x0";
      }
      {
        name = "eDP-1";
        width = 1920;
      height = 1080;
      workspace = "1";
      primary = false;
      position = "auto";
      enabled = true;
      }
    ];
  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "od1n";
    profile = "work";
    locale = "en_ZA.UTF-8";
    timezone = "Africa/Johannesburg";
  };

  userSettings = {
    username = "matthew";
    name = "Matthew";
    email = "matthew.winnan@mirasecurity.com";
  };


}
