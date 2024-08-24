{ config, pkgs, ... }:{
  imports = [
    ./fastfetch/fastfetch.nix
    ./wms/hyprland.nix
    ./wms/waybar.nix
    ./kitty.nix
    ./lf.nix
    ./wofi.nix
    ./helix.nix
    ./hypridle.nix
    ./hyprlock/hyprlock.nix
    ./dunst.nix
  ];
}
