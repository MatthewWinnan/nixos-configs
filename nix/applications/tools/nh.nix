# NixOptions DOCS -> https://mynixos.com/nixpkgs/options/programs.nh
{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  inherit (builtins) concatStringsSep length;
  inherit (lib.lists) zipListsWith;
  inherit (lib.strings) escapeShellArg;
  nh_package = inputs.nh.packages.${config.systemSettings.system}.nh;
in {
  programs.nh = {
    enable = true;
    package = nh_package;

    # path to the system flake
    flake = "/home/${config.userSettings.username}/NIX_REPO";

    # whether to let nh run gc on the store weekly
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5";
    };
  };

  # create an overlay for nix-output-monitor to match the inconsistent
  # and frankly ugly icons with nerdfonts ones. they look a little larger
  # than before, but overall consistency is better in general.
  nixpkgs.overlays = [
    (_: prev: let
      oldIcons = [
        "↑"
        "↓"
        "⏱"
        "⏵"
        "✔"
        "⏸"
        "⚠"
        "∅"
        "∑"
      ];
      newIcons = [
        "f062" # 
        "f063" # 
        "f520" # 
        "f04b" # 
        "f00c" # 
        "f04c" # 
        "f071" # 
        "f1da" # 
        "f04a0" # 󰒠
      ];
    in {
      nix-output-monitor = assert length oldIcons == length newIcons;
        prev.nix-output-monitor.overrideAttrs (o: {
          postPatch =
            (o.postPatch or "")
            + ''
              sed -i ${escapeShellArg (
                concatStringsSep "\n" (zipListsWith (a: b: "s/${a}/\\\\x${b}/") oldIcons newIcons)
              )} lib/NOM/Print.hs

              sed -i 's/┌/╭/' lib/NOM/Print/Tree.hs
            '';
        });
    })
  ];
}
