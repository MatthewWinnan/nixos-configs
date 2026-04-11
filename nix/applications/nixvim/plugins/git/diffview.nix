# DOCS -> https://github.com/sindrets/diffview.nvim
{
  programs.nixvim.plugins.diffview = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gd";
      action = "<cmd>DiffviewOpen<cr>";
      options.desc = "Diffview: Open diff";
    }
    {
      mode = "n";
      key = "<leader>gh";
      action = "<cmd>DiffviewFileHistory %<cr>";
      options.desc = "Diffview: File history";
    }
    {
      mode = "n";
      key = "<leader>gq";
      action = "<cmd>DiffviewClose<cr>";
      options.desc = "Diffview: Close";
    }
  ];
}
