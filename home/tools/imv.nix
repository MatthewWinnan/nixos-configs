#
# imv - Image viewer for tiling window managers
#
# Keybindings:
#   q        - Quit
#   j/k      - Next/previous image
#   h/l      - Pan left/right
#   +/-      - Zoom in/out
#   =        - Reset zoom
#   f        - Fullscreen
#   r        - Rotate clockwise
#   R        - Rotate counter-clockwise
#   x        - Close current image
#   d        - Delete image (moves to trash)
#
{ config, ... }:
let
  inherit (config.lib.stylix) colors;
in
{
  programs.imv = {
    enable = true;
    settings = {
      options = {
        # Background color
        background = "#${colors.base00}";

        # Start in fullscreen
        fullscreen = false;

        # Default to actual size, fit large images
        scaling_mode = "shrink";

        # Loop through images
        loop_input = true;

        # Smooth upscaling
        upscaling_method = "linear";

        # Show overlay with image info
        overlay = true;
        overlay_font = "monospace:12";

        # Slideshow interval (seconds)
        slideshow_duration = 5;

        # Suppress warnings
        suppress_default_binds = false;
      };

      aliases = {
        # Convenience aliases
        "next" = "imv-msg $imv_pid next";
        "prev" = "imv-msg $imv_pid prev";
        "zoom_in" = "imv-msg $imv_pid zoom 1";
        "zoom_out" = "imv-msg $imv_pid zoom -1";
      };

      binds = {
        # Navigation - vim style
        "j" = "next";
        "k" = "prev";
        "<Right>" = "next";
        "<Left>" = "prev";
        "<Shift+G>" = "goto -1";

        # Zoom
        "<Up>" = "zoom 1";
        "<Down>" = "zoom -1";
        "=" = "zoom actual";
        "w" = "zoom fit";
        "e" = "zoom fill";
        "+" = "zoom 1";
        "-" = "zoom -1";

        # Pan - vim style
        "h" = "pan 50 0";
        "l" = "pan -50 0";
        "<Shift+J>" = "pan 0 -50";
        "<Shift+K>" = "pan 0 50";

        # Rotate
        "r" = "rotate by 90";
        "<Shift+R>" = "rotate by -90";

        # Flip
        "<Shift+F>" = "flip horizontal";
        "<Shift+V>" = "flip vertical";

        # View controls
        "f" = "fullscreen";
        "c" = "center";
        "o" = "overlay";

        # Slideshow
        "s" = "slideshow";

        # File operations
        "x" = "close";
        "q" = "quit";

        # Copy path to clipboard
        "y" = "exec wl-copy $imv_current_file";
      };
    };
  };
}
