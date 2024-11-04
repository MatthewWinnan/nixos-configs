# Docs -> https://github.com/folke/noice.nvim
{
  programs.nixvim.plugins.noice = {
    enable = true;
    notify = {
      enabled = false;
    };
    messages = {
      enabled = true; # Adds a padding-bottom to neovim statusline when set to false for some reason
    };
    lsp = {
      message = {
        enabled = true;
      };
      progress = {
        enabled = true;
        view = "mini";
      };
    };
    popupmenu = {
      enabled = true;
      backend = "nui";
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
        icon = "";
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
  ];
}
