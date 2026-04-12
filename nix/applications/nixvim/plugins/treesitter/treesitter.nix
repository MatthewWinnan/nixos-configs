# DOCS -> https://github.com/nvim-treesitter/nvim-treesitter/
# NixVim DOCS -> https://nix-community.github.io/nixvim/plugins/treesitter/index.html
{pkgs, ...}: {
  programs.nixvim.plugins.treesitter = {
    enable = true;

    settings = {
      indent = {
        enable = true;
      };
      highlight = {
        enable = true;
      };
      folding.enable = true;
    };

    nixvimInjections = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };
}
