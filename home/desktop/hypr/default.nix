{config, lib, ...}: {
  imports = [
    ./hypridle.nix
    ./hyprlock/hyprlock.nix
    ./waybar.nix
    ./hyprland/hyprland.nix
  ];
}
