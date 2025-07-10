{
  imports = [
    ./fonts.nix
    ./stylix.nix
    ./icon-themes.nix
    # GTK enable does not exist, likely within nixosSystem context.
    # Home manager can consume it and is done under /home/default.nix
    #./gtk.nix
  ];
}
