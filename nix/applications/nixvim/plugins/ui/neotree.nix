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
        modified = {
          symbol = "●";
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

  # Renderers must be set via extraConfigLua because nixvim's settings
  # doesn't correctly translate the positional table structure neo-tree expects
  programs.nixvim.extraConfigLua = ''
    require("neo-tree").setup({
      filesystem = {
        renderers = {
          file = {
            { "indent" },
            { "icon" },
            {
              "container",
              content = {
                { "name", zindex = 10 },
                { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
                { "modified", zindex = 20, align = "right" },
                { "diagnostics", zindex = 20, align = "right" },
                { "git_status", zindex = 20, align = "right" },
              },
            },
          },
          directory = {
            { "indent" },
            { "icon" },
            {
              "container",
              content = {
                { "name", zindex = 10 },
                { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
                { "diagnostics", zindex = 20, align = "right" },
                { "git_status", zindex = 20, align = "right" },
              },
            },
          },
        },
      },
    })
  '';

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
