# https://github.com/MagicDuck/grug-far.nvim
# https://nix-community.github.io/nixvim/plugins/grug-far/index.html
{
  programs.nixvim.plugins.grug-far = {
    enable = true;
    settings = {
      headerMaxWidth = 80;
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = ["n" "x"];
      key = "<leader>sr";
      action.__raw = ''
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end
      '';
      options.desc = "Search and Replace (grug-far)";
    }
    {
      mode = ["n" "x"];
      key = "<leader>sw";
      action.__raw = ''
        function()
          local grug = require("grug-far")
          grug.open({
            transient = true,
            prefills = {
              search = vim.fn.expand("<cword>"),
            },
          })
        end
      '';
      options.desc = "Search Current Word (grug-far)";
    }
  ];
}
