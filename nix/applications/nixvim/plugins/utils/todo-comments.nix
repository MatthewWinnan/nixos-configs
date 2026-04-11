# DOCS -> https://github.com/folke/todo-comments.nvim
{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>st";
      action = "<cmd>TodoTelescope<cr>";
      options.desc = "Search TODO comments";
    }
  ];
}
