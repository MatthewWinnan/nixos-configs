{
deviceSettings = {
    type = "work";
    monitors = [
      {
      name = "DP-5";
      width = 1920;
      height = 1080;
      workspace = "1";
      primary = true;
      position = "0x0";
      }
      {
      name = "HDMI-A-2";
      # When I am at home I need to use larger resolution
      # width = 1920;
      # height = 1080;
      width = 1024;
      height = 768;
      workspace = "7";
        primary = false;
        # When I am at home the offset will need updating
        #position = "-1920x0"
        position = "-1024x0";
      }
      {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      workspace = "5";
        primary = false;
        position = "-2944x0";
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
