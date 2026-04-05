{config, ...}: {
  imports = [
    ./lf.nix
    ./wofi.nix
    ./walker.nix
    ./fastfetch.nix
    ./zathura.nix
    ./sioyek.nix
    ./imv.nix
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
