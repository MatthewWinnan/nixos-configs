{config, ...}: {
  imports = [
    ./fish.nix
    ./bash.nix
    ./nushell.nix
    ./zsh/default.nix
    ./starship.nix
  ];
}
