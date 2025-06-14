{lib, ...}: let
  inherit (lib.types) str enum listOf;
in {
  options = {
    deviceSettings = {
      type = lib.mkOption {
        type = enum ["laptop" "desktop" "vm"];
        default = "laptop";
        description = "The type/purpose of the device.";
      };

      headless = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Is this machine headless (will use the headless packages)";
      };

      monitors = lib.mkOption {
        type = lib.types.listOf (
          lib.types.submodule {
            options = {
              name = lib.mkOption {
                type = lib.types.str;
                example = "DP-1";
              };
              primary = lib.mkOption {
                type = lib.types.bool;
                default = false;
              };
              width = lib.mkOption {
                type = lib.types.int;
                example = 1920;
                default = 1920;
              };
              height = lib.mkOption {
                type = lib.types.int;
                example = 1080;
                default = 1080;
              };
              refreshRate = lib.mkOption {
                type = lib.types.int;
                default = 60;
              };
              position = lib.mkOption {
                type = lib.types.str;
                default = "auto";
              };
              enabled = lib.mkOption {
                type = lib.types.bool;
                default = true;
              };
              workspace = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = "1";
              };

              # For mode definitions check https://wiki.hyprland.org/Configuring/Monitors/#rotating
              # 0 -> normal (no transforms)
              # 1 -> 90 degrees
              # 2 -> 180 degrees
              # 3 -> 270 degrees
              # 4 -> flipped
              # 5 -> flipped + 90 degrees
              # 6 -> flipped + 180 degrees
              # 7 -> flipped + 270 degrees
              rotate_mode = lib.mkOption {
                type = enum ["0" "1" "2" "3" "4" "5" "6" "7"];
                default = "0";
              };
            };
          }
        );
        default = [];
      };
    };
  };
}
