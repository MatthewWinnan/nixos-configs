{
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions = {
      file-browser = {
        enable = true;
      };
      fzf-native = {
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
        };
        "q" = {
          __raw = "require('telescope.actions').close";
        };
      };
    };
      };
    };

    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fo" = "oldfiles";
      "<leader>fr" = "live_grep";
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
      "<leader>:" = "command_history";
    };

    # The option definition `plugins.telescope.keymapsSilent' no longer has effect
    # now that the `plugin.telescope.keymaps` implementation uses `<cmd>`.
    #keymapsSilent = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>";
      options = {
        desc = "[P]Open telescope buffers";
      };
    }
  ];
}
