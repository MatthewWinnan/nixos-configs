{config, ...}:{
  # Stylix setup
  # You can find the docs at https://stylix.danth.me/index.html
  stylix = {
    enable = true;
    targets = {
      gtk.enable = true;
      gnome.enable = true;
    };
    image = config.images.stylix_wallpaper;
    polarity = "dark";
  };
}
