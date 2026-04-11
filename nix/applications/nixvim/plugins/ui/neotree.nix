# DOCS -> https://github.com/nvim-neo-tree/neo-tree.nvim
{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    settings = {
      filesystem = {
        followCurrentFile.enabled = true;
        useLibuvFileWatcher = true;
        filteredItems = {
          visible = true;
          hideDotfiles = false;
          hideGitignored = true;
        };
      };
      close_if_last_window = true;
      popup_border_style = "rounded";
      enable_git_status = true;
      enable_diagnostics = true;
      default_component_configs = {
        indent = {
          with_expanders = true;
          expander_collapsed = "";
          expander_expanded = "";
        };
        icon = {
          folder_closed = "";
          folder_open = "";
          folder_empty = "󰜌";
        };
        git_status.symbols = {
          added = "✚";
          modified = "";
          deleted = "✖";
          renamed = "󰁕";
          untracked = "";
          ignored = "";
          unstaged = "󰄱";
          staged = "";
          conflict = "";
        };
      };
      window.width = 35;
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
