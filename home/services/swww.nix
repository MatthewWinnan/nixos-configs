# https://mynixos.com/home-manager/option/services.awww.enable
# I prefer having this over hyprpaper for the animated wallpaper
{
  inputs,
  pkgs,
  ...
}:
{
  services.awww = {
    # When disabled hyprpaper will be the default
    # see ./hyprpaper.nix
    enable = true;
  };
}
