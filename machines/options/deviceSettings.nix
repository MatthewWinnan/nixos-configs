{lib, ...}: let
  inherit (lib.types) enum;
in {
  options = {
    deviceSettings = {
      type = lib.mkOption {
        type = enum ["laptop" "desktop" "vm" "work"];
        default = "laptop";
        description = "The type/purpose of the device.";
      };

      headless = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Is this machine headless (will use the headless packages)";
      };

      greeter = lib.mkOption {
        type = enum ["tuigreet" "regreet"];
        default = "tuigreet";
        description = "Which login greeter to use. tuigreet is a TUI greeter, regreet is a GTK4 graphical greeter running inside Hyprland.";
      };

      location = lib.mkOption {
        type = enum ["home" "work"];
        default = "work";
        description = "Physical location of the machine (work/home). Controls network-dependent settings like caches and monitor layouts.";
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
                type = lib.types.float;
                default = 60.00;
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

              # Output bit depth: 8 (default SDR), 10 (HDR/deep color)
              bitdepth = lib.mkOption {
                type = lib.types.int;
                default = 8;
                description = "Output bit depth (8 or 10). Set to 10 for HDR-capable displays.";
              };

              # Colour management preset, see
              # https://wiki.hypr.land/Configuring/Basics/Monitors/#color-management-presets
              cm = lib.mkOption {
                type = lib.types.nullOr (enum [
                  "auto"
                  "srgb"
                  "dcip3"
                  "dp3"
                  "adobe"
                  "wide"
                  "edid"
                  "hdr"
                  "hdredid"
                ]);
                default = null;
                example = "hdr";
                description = "Colour management preset. Null leaves Hyprland's default (srgb).";
              };

              # Only meaningful when cm is "hdr" or "hdredid".
              sdrbrightness = lib.mkOption {
                type = lib.types.nullOr lib.types.float;
                default = null;
                example = 1.2;
                description = "SDR brightness in HDR mode. Typically 1.0 ... 2.0. Null uses Hyprland's default (1.0).";
              };

              sdrsaturation = lib.mkOption {
                type = lib.types.nullOr lib.types.float;
                default = null;
                example = 0.98;
                description = "SDR saturation in HDR mode. Null uses Hyprland's default (1.0).";
              };

              # Transfer function assumed for sRGB content on an SDR display.
              # "default" follows render:cm_sdr_eotf. srgb and gamma22 differ
              # almost entirely in the shadows, so this is the lever for
              # near-black detail (PLUGE).
              sdr_eotf = lib.mkOption {
                type = lib.types.nullOr (enum ["default" "gamma22" "srgb"]);
                default = null;
                example = "srgb";
                description = "SDR transfer function. Null uses Hyprland's default (follows render:cm_sdr_eotf).";
              };

              # Luminance range SDR content is mapped into when in HDR mode.
              # Match these to the panel's EDID HDR static metadata block
              # (edid-decode: "Desired content min/max luminance").
              sdr_min_luminance = lib.mkOption {
                type = lib.types.nullOr lib.types.float;
                default = null;
                example = 0.125;
                description = "SDR minimum luminance in nits for SDR->HDR mapping. Null uses Hyprland's default (0.2).";
              };

              sdr_max_luminance = lib.mkOption {
                type = lib.types.nullOr lib.types.int;
                default = null;
                example = 400;
                description = "SDR maximum luminance in nits for SDR->HDR mapping. Null uses Hyprland's default (80).";
              };
            };
          }
        );
        default = [];
      };
    };
  };
}
