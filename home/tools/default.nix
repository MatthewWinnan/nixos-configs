{config, ...}: {
  imports = [
    ./lf.nix
    ./wofi.nix
    ./fastfetch.nix
    ./zathura.nix
    ./sioyek.nix
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
