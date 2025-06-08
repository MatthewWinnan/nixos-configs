# Generic machine configuration and role selection
{
  deviceSettings = {
    type = "vm";
    headless = true;
  };

  systemSettings = {
    system = "x86_64-linux";
    hostname = "m1m1r";
    profile = "personal";
    locale = "en_ZA.UTF-8";
    timezone = "Africa/Johannesburg";
  };

  userSettings = {
    username = "matthew";
    name = "Matthew";
    email = "mcwinnan@gmail.com";
  };
}
