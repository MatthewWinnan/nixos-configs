# https://mynixos.com/nixpkgs/options/programs.noisetorch
{
  pkgs,
  config,
  ...
}: {
  programs.noisetorch = {
    enable = true;
  };
}
