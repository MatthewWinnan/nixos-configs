# DOCS -> https://mynixos.com/nixpkgs/options/programs.steam
{
  pkgs,
  config,
  ...
}: {
  programs.steam = {
    # Obviously only enable if this is a gaming machine
    enable = config.systemSettings.profile == "gaming";

    # Some wine tricks stuff
    protontricks.enable = config.systemSettings.profile == "gaming";

    # For now keep closed but want to be aware
    remotePlay.openFirewall = false;

    gamescopeSession.enable = config.systemSettings.profile == "gaming";
  };
}
