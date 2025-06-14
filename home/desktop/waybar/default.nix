{
  lib,
  pkgs,
  config,
  ...
}: let
  settings = import (./settings + "/${config.userSettings.waybar}.nix") {inherit pkgs;};
  style = builtins.readFile (./style + "/${config.userSettings.waybar}.css");
in {
  # We need to override stylix mostly
  programs.waybar = lib.mkForce {
    enable = true;
    inherit settings style;
  };
}
