# https://mynixos.com/home-manager/option/services.swww.enable
# I prefer having this over hyprpaper for the animated wallpaper
{inputs, pkgs, ...}:{
  services.swww = {
    # When disabled hyprpaper will be the default
    # see ./hyprpaper.nix
    enable = true;
    package = inputs.swww.packages.${pkgs.system}.swww;
  };
}
