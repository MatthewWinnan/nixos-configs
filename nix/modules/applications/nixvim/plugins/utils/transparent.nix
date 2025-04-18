# DOCS -> https://github.com/xiyaowong/transparent.nvim/
{
  programs.nixvim.plugins.transparent = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>TransparentToggle<cr>";
      options = {
        desc = "Toggles the transparent plugin";
      };
    }
  ];
}
