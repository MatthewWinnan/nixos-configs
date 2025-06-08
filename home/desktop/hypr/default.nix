{
  config,
  lib,
  ...
}: {
  imports = [
    ./hypridle.nix
    ./hyprlock/hyprlock.nix
    ./hyprland/hyprland.nix
  ];
}
