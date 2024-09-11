{config, ...}: {

  imports = [
    ./fish.nix
    ./lf.nix
    ./wofi.nix
    ./helix.nix
    ./kitty.nix
    ./fastfetch/fastfetch.nix
    ./zathura.nix
  ];
}
