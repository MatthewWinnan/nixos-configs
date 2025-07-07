# https://mynixos.com/home-manager/option/services.swww.enable
# I prefer having this over hyprpaper for the animated wallpaper
{inputs, pkgs, ...}:{
  services.swww = {
    enable = true;
    package = inputs.swww.packages.${pkgs.system}.swww;
  };
}
