# DOCS -> https://github.com/moll/vim-bbye
{pkgs, ...}: {
  programs.nixvim.plugins.vim-bbye = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>Bdelete<cr>";
      options.desc = "Deletes Buffer Keeps Window";
    }
  ];
}
