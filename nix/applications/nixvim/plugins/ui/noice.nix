# Docs -> https://github.com/folke/noice.nvim
{
  programs.nixvim.plugins.noice = {
    enable = true;
    settings = {
      messages = {
        enabled = true; # Adds a padding-bottom to neovim statusline when set to false for some reason
      };
      notify = {
        enabled = true; # Route vim.notify() through noice -> nvim-notify
      };
      popupmenu = {
        enabled = true;
        backend = "nui";
      };
      lsp = {
        message = {
          enabled = true;
        };
        progress = {
          enabled = true;
          view = "mini";
          throttle = 33; # ~30fps, matches your nvim-notify fps=60 / 2
        };
        # Override LSP markdown rendering so cmp and other plugins use treesitter
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      format = {
        filter = {
          pattern = [
            ":%s*%%s*s:%s*"
            ":%s*%%s*s!%s*"
            ":%s*%%s*s/%s*"
            "%s*s:%s*"
            ":%s*s!%s*"
            ":%s*s/%s*"
          ];
          icon = "";
          lang = "regex";
        };
        replace = {
          pattern = [
            ":%s*%%s*s:%w*:%s*"
            ":%s*%%s*s!%w*!%s*"
            ":%s*%%s*s/%w*/%s*"
            "%s*s:%w*:%s*"
            ":%s*s!%w*!%s*"
            ":%s*s/%w*/%s*"
          ];
          icon = "󱞪";
          lang = "regex";
        };
      };
      # Routes replace your old hand-rolled vim.notify filter
      routes = [
        # Skip "No information available" hover messages (was filtered in nvim-notify extraConfigLua)
        {
          filter = {
            event = "notify";
            find = "No information available";
          };
          opts = {
            skip = true;
          };
        }
        # Suppress LSP progress in insert mode (was fidget's suppress_on_insert)
        {
          filter = {
            event = "lsp";
            kind = "progress";
            cond.__raw = ''
              function()
                return vim.api.nvim_get_mode().mode:sub(1,1) == "i"
              end
            '';
          };
          opts = {
            skip = true;
          };
        }
      ];
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>nh";
      action = "<cmd>Noice history<cr>";
      options = {
        desc = "Noice shows the message history";
      };
    }
    {
      mode = "n";
      key = "<leader>nl";
      action = "<cmd>Noice last<cr>";
      options = {
        desc = "Noice shows the last message in a popup";
      };
    }
    {
      mode = "n";
      key = "<leader>ne";
      action = "<cmd>Noice errors<cr>";
      options = {
        desc = "Noice shows the error messages in a split. Last errors on top";
      };
    }
    {
      mode = "n";
      key = "<leader>nv";
      action = "<cmd>Noice telescope<cr>";
      options = {
        desc = "Noice opens the notifications as telescope";
      };
    }
    {
      mode = "n";
      key = "<leader>nd";
      action = "<cmd>Noice dismiss<cr>";
      options = {
        desc = "Dismiss all visible notifications";
      };
    }
  ];
}
