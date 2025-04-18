# DOCS -> https://mynixos.com/nixpkgs/options/programs.gamemode
{
  pkgs,
  config,
  ...
}: {
  programs.gamemode = {
    enable = config.systemSettings.profile == "gaming";
  };
}
