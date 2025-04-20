# DOCS -> https://github.com/nvim-neo-tree/neo-tree.nvim
{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    filesystem.followCurrentFile.enabled = true;
    closeIfLastWindow = true;
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
