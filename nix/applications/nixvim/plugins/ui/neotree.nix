# DOCS -> https://github.com/nvim-neo-tree/neo-tree.nvim
{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    settings = {
    filesystem.followCurrentFile.enabled = true;
    close_if_last_window = true;
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>nt";
      action = "<cmd>Neotree<cr>";
      options = {
        desc = "Open Neotree";
      };
    }
  ];
}
