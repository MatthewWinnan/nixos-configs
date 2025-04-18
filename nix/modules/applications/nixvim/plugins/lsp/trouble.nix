# DOCS -> hTrouble diagnostics togglettps://github.com/folke/trouble.nvim
{
  programs.nixvim.plugins.trouble = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>dx";
      action = "<cmd>Trouble diagnostics toggle focus=false win.positon=right<cr>";
      options = {
        desc = "Diagnostics (Trouble)";
      };
    }

    {
      mode = "n";
      key = "<leader>dX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      options = {
        desc = "Buffer Diagnostics (Trouble)";
      };
    }

    {
      mode = "n";
      key = "<leader>ds";
      action = "<cmd>Trouble symbols toggle focus=false<cr>";
      options = {
        desc = "Symbols (Trouble)";
      };
    }

    {
      mode = "n";
      key = "<leader>dl";
      action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
      options = {
        desc = "LSP Definitions / references / ... (Trouble)";
      };
    }

    {
      mode = "n";
      key = "<leader>dL";
      action = "<cmd>Trouble loclist toggle<cr>";
      options = {
        desc = "Location List (Trouble)";
      };
    }

    {
      mode = "n";
      key = "<leader>dq";
      action = "<cmd>Trouble qflist toggle<cr>";
      options = {
        desc = "Quickfix List (Trouble)";
      };
    }
  ];
}
