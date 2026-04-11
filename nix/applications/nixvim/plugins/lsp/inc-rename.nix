# DOCS -> https://github.com/smjonas/inc-rename.nvim
{
  programs.nixvim.plugins.inc-rename = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>rn";
      action.__raw = "function() return ':IncRename ' .. vim.fn.expand('<cword>') end";
      options = {
        desc = "Incremental rename";
        expr = true;
      };
    }
  ];
}
