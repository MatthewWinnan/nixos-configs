{
  config,
  lib,
  ...
}:
# let
#   not_work = builtins.elem config.systemSettings.profile ["gaming" "personal"];
# in
{
  imports = [
    ./newsboat
    ./schizofox
    ./yazi
    ./chromium
    ./direnv.nix
    ./helix
    ./qutebrowser
    ./rmpc
    ./anyrun
    ./streamlink
    ./obs-studio
    ./claude
    ./tmux
    ./lazydocker
    ./satty
  ];
}
