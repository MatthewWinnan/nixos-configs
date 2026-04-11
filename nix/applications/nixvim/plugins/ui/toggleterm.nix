# DOCS -> https://github.com/akinsho/toggleterm.nvim
{
  programs.nixvim.plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      float_opts = {
        border = "rounded";
        width = 120;
        height = 30;
      };
      size.__raw = ''
        function(term)
          if term.direction == "horizontal" then
            return math.floor(vim.o.lines * 0.5)
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.5)
          end
        end
      '';
      open_mapping.__raw = "[[<C-b>]]";
      shade_terminals = false;
      persist_size = true;
      persist_mode = true;
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>tp";
      action = "<cmd>1ToggleTerm direction=float<cr>";
      options.desc = "Toggle floating terminal (pop)";
    }
    {
      mode = "n";
      key = "<leader>th";
      action = "<cmd>2ToggleTerm direction=horizontal<cr>";
      options.desc = "Toggle horizontal terminal";
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = "<cmd>3ToggleTerm direction=vertical<cr>";
      options.desc = "Toggle vertical terminal";
    }
    {
      mode = "t";
      key = "<C-b>";
      action = "<cmd>ToggleTerm<cr>";
      options.desc = "Toggle terminal (from terminal mode)";
    }
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Exit terminal mode";
    }
  ];
}
