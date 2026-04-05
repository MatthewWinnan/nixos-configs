{
  config,
  lib,
  ...
}: {
  imports = [
    ./mako.nix
    ./hypr
    ./wlogout/wlogout.nix
    ./xdg.nix
    ./waybar
    ./stylix.nix
  ];
}
