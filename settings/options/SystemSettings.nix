{ lib, ... }:

let
  inherit (lib.types) str enum listOf;
in {
options = {
systemSettings = {
      system = lib.mkOption {
        type = str;
        default = "x86_64-linux";
        description = "System architecture.";
      };
      hostname = lib.mkOption {
        type = str;
        default = "th0r";
        description = "Hostname of the system.";
      };
      profile = lib.mkOption {
        type = enum [ "personal" "work" "gaming" ];
        default = "personal";
        description = "The role for this system.";
      };
      locale = lib.mkOption {
        type = str;
        default = "en_ZA.UTF-8";
        description = "System locale.";
      };
      timezone = lib.mkOption {
        type = str;
        default = "Africa/Johannesburg";
        description = "System timezone.";
      };
    };
  };
}
