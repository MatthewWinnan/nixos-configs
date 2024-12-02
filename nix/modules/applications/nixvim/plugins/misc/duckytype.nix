# DOCS -> https://github.com/kwakzalver/duckytype.nvim

{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "duckytype";
      src = pkgs.fetchFromGitHub {
        owner = "kwakzalver";
        repo = "duckytype.nvim";
        rev = "fa59fbd7cf8407337bfe07d01b361a3449f34743";
        hash = "sha256-izinGyYP2xwEwHbBtEeiGe+SVoaSQ4NvfAwjaSbc93M=";
      };
    })
  ];


  programs.nixvim.extraConfigLua = ''
    require('duckytype').setup{
    number_of_words = 10,
    highlight = {
      good = "String",
      bad = "Error",
      remaining = "Function",
  },
    }
    '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>dt";
      action = "<cmd>DuckyType<cr>";
      options.desc = "Like MonkeyType, but avian. 🦆";
    }
  ];
}
