# DOCS -> https://github.com/rmagatti/auto-session/
{
  programs.nixvim.plugins.auto-session = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ar";
      action = "<cmd>SessionSave<cr>";
      options = {
        desc = "[S]Saves the current session";
      };
    }
    {
      mode = "n";
      key = "<leader>as";
      action = "<cmd>Autosession search<cr>";
      options = {
        desc = "[S]Opens a vm.ui to view sessions";
      };
    }
    {
      mode = "n";
      key = "<leader>ad";
      action = "<cmd>Autosession delete<cr>";
      options = {
        desc = "[S]open a vim.ui.select picker to choose a session to delete.";
      };
    }
  ];
}

