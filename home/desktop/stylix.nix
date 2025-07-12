{config, lib, ...}: {
  # Stylix setup
  # You can find the docs at https://stylix.danth.me/index.html
  # We just enable the targets here?
  # https://nix-community.github.io/stylix/options/platforms/home_manager.html
  stylix = {
    enable = true;
    targets = lib.mkMerge [(
      {
      gtk.enable = true;
      gnome.enable = true;
      nixvim.enable = false;
      # Disable hyrpaper from automatically starting so I can rather use swww
      hyprland.hyprpaper.enable = !config.services.swww.enable;
    }
    )
      (
        lib.mkIf (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming") {
      # Only add these if I am sure I have these targets, the above machines will have them
      # Disable nixcord here
      # https://nix-community.github.io/stylix/options/modules/discord.html
    nixcord.enable = false;
    vencord.enable = false;
    vesktop.enable = false;
  }

      )
    ];
  };
}
