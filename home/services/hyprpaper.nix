# https://mynixos.com/search?q=hyprpaper
# https://github.com/hyprwm/hyprpaper
# Only enable it when swww is disabled
{config, ...}:{
  services.hyprpaper = {
    enable = !config.services.swww.enable;
  };
}
