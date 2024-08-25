{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      background = {
      monitor ="";
        #path = ./images/gray0_ctp_on_line.png;
      path = "$HOME/NIX_REPO/home-manager/modules/hyprlock/images/nix_wallpaper.png";
      blur_passes = 0;
      color = "rgb(24273a)";
      };

      label = [
        # TIME
        {
  monitor ="";
  text = "$TIME";
  color = "rgb(cad3f5)";
  font_size = 90;
  font_family = "JetBrainsMono Nerd Font";
  position = "30, 100";
  halign = "left";
  valign = "bottom";
}
# DATE
        {
  monitor ="";
  text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
  color = "rgb(cad3f5)";
  font_size = 25;
  font_family = "JetBrainsMono Nerd Font";
  position = "30, 30";
  halign = "left";
  valign = "bottom";
}];

# USER AVATAR
image = {
  monitor ="";
          #path = ./images/1544x1544_circle.png;
  path = "$HOME/NIX_REPO/home-manager/modules/hyprlock/images/cat_icon_2.png";
  size = 100;
  border_color = "rgb(c6a0f6)";
  position = "0, 75";
  halign = "center";
  valign = "center";
};

# INPUT FIELD
input-field = [{
  monitor ="";
  size = "300, 60";
  outline_thickness = 4;
  dots_size = 0.2;
  dots_spacing = 0.2;
  dots_center = true;
  outer_color = "rgb(c6a0f6)";
  inner_color = "rgb(363a4f)";
  font_color = "rgb(cad3f5)";
  fade_on_empty = false;
  placeholder_text = ''<span foreground="##cad3f5"><i>󰌾 Logged in as </i><span foreground="##c6a0f6">$USER</span></span>'';
  hide_input = false;
  check_color = "rgb(c6a0f6)";
  fail_color = "rgb(ed8796)";
  fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
  capslock_color = "rgb(eed49f)";
  position = "0, -47";
  halign = "center";
  valign = "center";
}];

    };
  };
}
