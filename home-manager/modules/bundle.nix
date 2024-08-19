{ config, pkgs, ... }:{
  imports = [
    ./fastfetch/fastfetch.nix
    ./wms/hyprland.nix
    ./wms/waybar.nix
    ./kitty.nix
    ./ranger.nix
    ./lf.nix
  ];
}
