# Themes can be found here -> https://github.com/nvim-telescope/telescope.nvim/blob/df534c3042572fb958586facd02841e10186707c/lua/telescope/themes.lua#L4
# Can define your own too eh.
{
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions = {
      # https://github.com/nvim-telescope/telescope-file-browser.nvim
      file-browser = {
        enable = true;
      };
      fzf-native = {
        enable = true;
      };
      # https://github.com/debugloop/telescope-undo.nvim
      undo = {
        enable = true;
      };

      ui-select = {
        enable = true;
      };
    };

    settings = {
      defaults = {
        set_env.COLORTERM = "truecolor";
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
        layout_config = {
          horizontal = {
            prompt_position = "bottom";
          };
        };
        sorting_strategy = "ascending";
        mappings = {
          n = {
            "d" = {
              __raw = "require('telescope.actions').delete_buffer";
              # We instead use the command from https://github.com/moll/vim-bbye

              # I am getting:
              # 11:18:09 msg_show   Bdelete :!Bdelete
              # [No write since last change]
              # 11:18:09 msg_show   Bdelete fish: Unknown command: Bdelete
              # fish:
              # Bdelet
              # 11:18:09 msg_show   Bdelete e
              # ^~~~~~^
              # 11:18:09 msg_show   Bdelete shell returned 127

              # Check DOCS :help telescope.mappings
              #__raw = "{\"<cmd>Bdelete<cr>\", type = \"command\"}";
            };
            "q" = {
              __raw = "require('telescope.actions').close";
            };
          };
        };
      };

      pickers = {
        find_files = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        buffers = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        live_grep = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        help_tags = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        keymaps = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        diagnostics = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        autocommands = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        commands = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        marks = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        man_pages = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        git_files = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        git_status = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        git_commits = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };

        command_history = {
          theme = "ivy";
          sort_mru = true;
          sort_lastused = true;
          initial_mode = "normal";
        };
      };
    };

    keymaps = {
      "<leader>tb" = {
        action = "buffers";
        options = {
          desc = "[P]Open telescope buffers";
        };
      };

      "<leader>tf" = {
        action = "find_files";
        options = {
          desc = "[P]Find files in the current working directory";
        };
      };

      "<leader>tr" = "live_grep";
      "<leader>sh" = "help_tags";
      "<leader>sk" = "keymaps";
      "<leader>sd" = "diagnostics";
      "<leader>sa" = "autocommands";
      "<leader>sc" = "commands";
      "<leader>sm" = "marks";
      "<leader>sM" = "man_pages";
      "<leader>gf" = "git_files";
      "<leader>gc" = "git_commits";
      "<leader>gs" = "git_status";
      "<leader>tc" = "command_history";
    };

    # The option definition `plugins.telescope.keymapsSilent' no longer has effect
    # now that the `plugin.telescope.keymaps` implementation uses `<cmd>`.
    #keymapsSilent = true;
  };

  # Keeping this here for reference on how I can add pretty nice custom keys
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>te";
      action = "<cmd>Telescope file_browser sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>";
      options = {
        desc = "[P]Open telescope file_browser";
      };
    }
    {
      mode = "n";
      key = "<leader>tu";
      action = "<cmd>Telescope undo initial_mode=normal theme=ivy<cr>";
      options = {
        desc = "[P]Open telescope undo";
      };
    }
  ];
}
