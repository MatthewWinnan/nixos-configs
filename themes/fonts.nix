{pkgs, ...}:{

fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts._0xproto
    #(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

}
