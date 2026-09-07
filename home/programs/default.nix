{
  config,
  lib,
  ...
}: {
  imports = [
    ./newsboat
    ./schizofox
    ./yazi
    ./chromium
    ./direnv.nix
    ./gpg.nix
    ./helix
    ./qutebrowser
    ./rmpc
    ./beets
    ./anyrun
    ./streamlink
    ./obs-studio
    ./claude
    ./tmux
    ./lazydocker
    ./satty
  ];
}
