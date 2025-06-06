# Some generic useful links:
# VIM Plugins -> https://vimawesome.com/
# NIXVIM Docs -> https://nix-community.github.io/nixvim/user-guide/install.html
# Basic commands -> https://www.worldtimzone.com/res/vi.html
# Useful guide on using macros -> https://www.redhat.com/en/blog/use-vim-macro
{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./autocmds.nix
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavor = "macchiato";
      };
    };
    # colorschemes.oxocarbon.enable = true;
  };
}
