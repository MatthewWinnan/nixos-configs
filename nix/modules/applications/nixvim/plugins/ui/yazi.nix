# Docs -> https://github.com/mikavilpas/yazi.nvim/
{
  programs.nixvim.plugins.yazi = {
    enable = true;
    settings = {
      enable_mouse_support = true;
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>lf";
      action = ''<cmd>lua require("yazi").yazi()<cr>'';
      options = {
        desc = "[P]Opens the yazi file browser";
      };
    }
  ];
}
