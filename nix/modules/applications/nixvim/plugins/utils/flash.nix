# https://github.com/folke/flash.nvim
{
  programs.nixvim.plugins.flash = {
    enable = true;
    settings = {
        jump.autojump = true;
        search.mode = "fuzzy";
        labels = "asdfghjklqwertyuiopzxcvbnm";
      label = {
        uppercase = false;
        rainbow = {
          enabled = false;
          shade = 5;
        };
      };
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>fs";
      action = "<cmd>lua require('flash').jump()<cr>";
      options = {
        desc = "Flash";
      };
    }

    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "<leader>fS";
      action = "<cmd>lua require('flash').treesitter()<cr>";
      options = {
        desc = "Flash Treesitter";
      };
    }

    {
      mode = "o";
      key = "r";
      action = "<cmd>lua require('flash').remote()<cr>";
      options = {
        desc = "Remote Flash";
      };
    }

    {
      mode = [
        "x"
        "o"
        "n"
      ];
      key = "<leader>fr";
      action = "<cmd>lua require('flash').treesitter_search()<cr>";
      options = {
        desc = "Treesitter Search";
      };
    }
  ];
}
