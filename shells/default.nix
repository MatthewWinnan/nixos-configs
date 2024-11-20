{ pkgs }:

{
  python = import ./python.nix {inherit pkgs;};
  taskit = import ./taskit_dev.nix {inherit pkgs;};
}
