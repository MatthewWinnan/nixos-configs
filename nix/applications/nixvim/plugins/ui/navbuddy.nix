# DOCS -> https://github.com/SmiteshP/nvim-navbuddy
{
  programs.nixvim.plugins.navbuddy = {
    enable = true;
    lsp = {
      autoAttach = true;
      preference = [];
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ld";
      action = "<cmd>:Navbuddy<cr>";
      options = {
        desc = "Triggers the nabbuddy browser";
      };
    }
  ];
}
