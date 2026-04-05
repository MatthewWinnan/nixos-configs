# https://github.com/Gerg-L/spicetify-nix
# https://gerg-l.github.io/spicetify-nix/
{
  inputs,
  config,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming";

    # Theme configuration
    # Available themes: https://github.com/Gerg-L/spicetify-nix/blob/master/docs/THEMES.md
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    # Extensions add extra functionality
    # Available extensions: https://github.com/Gerg-L/spicetify-nix/blob/master/docs/EXTENSIONS.md
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # Better shuffle algorithm
    ];
  };
}
