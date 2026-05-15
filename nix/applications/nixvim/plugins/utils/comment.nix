# https://github.com/folke/ts-comments.nvim
# Treesitter-aware commenting (handles embedded languages)
# Replaces comment.nvim
{
  programs.nixvim.plugins.ts-comments = {
    enable = true;
  };
}
