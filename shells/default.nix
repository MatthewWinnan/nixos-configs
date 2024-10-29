{ pkgs }:

{
 python = import ./python.nix {inherit pkgs;};
}
