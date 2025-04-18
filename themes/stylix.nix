{config, ...}: {
  # Stylix setup
  # You can find the docs at https://stylix.danth.me/index.html
  stylix = {
    enable = true;
    targets = {
      gtk.enable = true;
      gnome.enable = true;

      # Not sure when this was introduced but enabling messes up my current config,
      # I am managing this inside of nixvim.nix
      nixvim.enable = false;
    };
    image = config.images.stylix_wallpaper;
    polarity = "dark";
  };
}
