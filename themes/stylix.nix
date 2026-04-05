{config, ...}: {
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

    # Opacity settings - popups set to 1.0 to fix transparent context menus
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.8; # Keep terminal transparency
    };
  };
}
