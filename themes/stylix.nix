{ config, pkgs, inputs, ... }:
{
  # Just to pull stylix into nixos
  # You can find the docs at https://stylix.danth.me/index.html
  stylix = {
    enable = true;
    targets = {
      nixvim.enable = false;
    };
    image = config.images.stylix_wallpaper;
    polarity = "dark";

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 24;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    # Brighten muted foreground colors for better contrast against dark background
    override = {
      base03 = "6e738d"; # surface1 → overlay0 (comments/subtle text)
      base04 = "a5adc8"; # surface2 → brighter (command arguments/dark fg)
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
