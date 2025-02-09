{pkgs, ...}:{

fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols

    # From the following change we need to refer to it per package
    # https://github.com/NixOS/nixpkgs/pull/354543
    # For the list of packages
    # https://mynixos.com/nixpkgs/packages/nerd-fonts
    nerd-fonts._0xproto
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];

}
