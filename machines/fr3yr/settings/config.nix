# Generic machine configuration and role selection
{
  deviceSettings = {
    type = "vm"; # Using vm type for embedded/single-purpose device
    headless = true;
  };

  systemSettings = {
    system = "aarch64-linux";
    hostname = "fr3yr";
    profile = "personal";
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
