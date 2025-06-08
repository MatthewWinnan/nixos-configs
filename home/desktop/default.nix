{
  config,
  lib,
  ...
}: {
  imports = [
    ./dunst.nix
    ./hypr
    ./wlogout/wlogout.nix
    ./xdg.nix
    ./waybar
  ];
}
