#
# Mako - Wayland-native notification daemon
#
# Commands:
#   makoctl dismiss       - Dismiss latest notification
#   makoctl dismiss -a    - Dismiss all notifications
#   makoctl restore       - Show last notification from history
#   makoctl mode -t dnd   - Toggle do-not-disturb
#
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.lib.stylix) colors;
in
{
  # Let Stylix handle mako theming, just override behavior settings
  services.mako = {
    enable = true;

    settings = {
      # Appearance - let Stylix handle colors, override structure
      border-radius = 8;
      border-size = 2;
      padding = lib.mkForce "12";
      margin = lib.mkForce "12";

      # Behavior
      default-timeout = 5000; # 5 seconds
      layer = "overlay";
      anchor = "top-right";
      width = 350;
      height = 150;
      max-visible = 5;
      sort = "-time";

      # Icons
      icons = true;
      max-icon-size = 48;
      icon-path = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";

      # Urgency settings
      "urgency=low" = {
        border-color = "#${colors.base03}";
        default-timeout = 3000;
      };

      "urgency=normal" = {
        border-color = "#${colors.base0D}";
        default-timeout = 5000;
      };

      "urgency=critical" = {
        border-color = "#${colors.base08}";
        default-timeout = 0;
      };

      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };
}
