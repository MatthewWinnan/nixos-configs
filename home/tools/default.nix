{config, ...}: {

  imports = [
    ./fish.nix
    ./lf.nix
    ./wofi.nix
    ./helix.nix
    ./kitty.nix
    ./fastfetch.nix
    ./zathura.nix
    ./rofi/default.nix
    ./btop.nix
    ./git/default.nix
    ./tealdeer.nix
    ./ripgrep.nix
    ./zellij/default.nix
  ];
}
