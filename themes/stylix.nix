{config, ...}:{
  # Stylix setup
  stylix = {
    enable = true;
    targets = {
      gtk.enable = true;
    };
    image = config.images.stylix_wallpaper;
  };
}
