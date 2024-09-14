{lib, pkgs, ...}: {
  # We need to override stylix
  services.dunst = lib.mkForce {
    enable = true;

    iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };

    settings = {
      global = {
      icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";
      frame_color = "#8aadf4";
        separator_color= "frame";
        enable_recursive_icon_lookup = true;
      };
    urgency_low = {
      background = "#24273a";
      foreground = "#cad3f5";
      };

    urgency_normal = {
background = "#24273a";
foreground = "#cad3f5";
    };
urgency_critical ={
background = "#24273a";
foreground = "#cad3f5";
      frame_color = "#f5a97f";
    };
    };
  };
}
