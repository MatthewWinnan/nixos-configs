{config, ...}: {
  imports = [
    ./lf.nix
    ./wofi.nix
    ./helix.nix
    ./fastfetch.nix
    ./zathura.nix
    ./rofi/default.nix
    ./btop.nix
    ./git/default.nix
    ./tealdeer.nix
    ./ripgrep.nix
    ./zellij/default.nix
    ./fzf.nix
    ./zoxide.nix
    ./eza.nix
    ./bat/default.nix
  ];
}
