{config, ...}: {
  # Stylix setup
  # You can find the docs at https://stylix.danth.me/index.html
  # We just enable the targets here?
  # https://nix-community.github.io/stylix/options/platforms/home_manager.html
  stylix = {
    enable = true;
    targets = {
      gtk.enable = true;
      gnome.enable = true;
      nixvim.enable = false;
      # Disable hyrpaper from automatically starting so I can rather use swww
      hyprland.hyprpaper.enable = false;
    };
  };
}
