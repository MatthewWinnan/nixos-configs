{lib, ...}: let
  inherit (lib.types) str enum listOf;
in {
  options = {
    userSettings = {
      username = lib.mkOption {
        type = str;
        default = "h3rm3s";
        description = "Username of the system user.";
      };
      name = lib.mkOption {
        type = str;
        default = "Matthew";
        description = "Full name of the user.";
      };
      email = lib.mkOption {
        type = str;
        default = "mcwinnan@gmail.com";
        description = "Email address of the user.";
      };
      browser = lib.mkOption {
        type = str;
        default = "qutebrowser";
        description = "The default browser of the user.";
      };
    };
  };
}
