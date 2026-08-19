# Some generic useful links:
# VIM Plugins -> https://vimawesome.com/
# NIXVIM Docs -> https://nix-community.github.io/nixvim/user-guide/install.html
# Basic commands -> https://www.worldtimzone.com/res/vi.html
# Useful guide on using macros -> https://www.redhat.com/en/blog/use-vim-macro
{inputs, ...}: {
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./autocmds.nix
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;

    # flake.nix sets inputs.nixvim.inputs.nixpkgs.follows = "nixpkgs", which
    # overrides the nixpkgs nixvim pins itself. Nixvim cannot tell a deliberate
    # follows from an accidental one, so it warns. Naming the source here says
    # the override is intended and silences it, while keeping a single nixpkgs
    # in the closure - the alternative (dropping the follows) pulls in a second
    # full nixpkgs just for nixvim.
    nixpkgs.source = inputs.nixpkgs;
    nixpkgs.config.allowUnfree = true;

    defaultEditor = true;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavor = "macchiato";
      };
    };
  };
}
