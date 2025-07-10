{pkgs, ...}: {
  imports = [
    ./steam.nix
    ./gamemode.nix
    ./protonup.nix
    ./noisetorch.nix
  ];
}
