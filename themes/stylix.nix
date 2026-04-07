{ config, ... }:
{
  # Just to pull stylix into nixos
  # You can find the docs at https://stylix.danth.me/index.html
  stylix = {
    enable = true;
    targets = {
      # Not sure when this was introduced but enabling messes up my current config,
      # I am managing this inside of nixvim.nix
      nixvim.enable = false;
    };
    image = config.images.stylix_wallpaper;
    polarity = "dark";

    base16Scheme = {
      base00 = "1e1e2e"; # Base
      base01 = "181825"; # Mantle
      base02 = "313244"; # Surface0
      base03 = "45475a"; # Surface1
      base04 = "585b70"; # Surface2
      base05 = "cdd6f4"; # Text
      base06 = "f5e0dc"; # Rosewater
      base07 = "b4befe"; # Lavender
      base08 = "f38ba8"; # Red
      base09 = "fab387"; # Peach
      base0A = "f9e2af"; # Yellow
      base0B = "a6e3a1"; # Green
      base0C = "94e2d5"; # Teal
      base0D = "89b4fa"; # Blue
      base0E = "cba6f7"; # Mauve
      base0F = "f2cdcd"; # Flamingo
    };

    # Opacity settings - popups set to 1.0 to fix transparent context menus
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.8; # Keep terminal transparency
    };
  };
}
