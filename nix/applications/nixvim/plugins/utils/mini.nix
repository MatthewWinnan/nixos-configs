# https://github.com/echasnovski/mini.nvim
{
  programs.nixvim.plugins.mini = {
    enable = true;

    modules = {
      # https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
      ai = {};

      # https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
      cursorword = {};

      # https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
      # I have hlchunk for this now
      # indentscope = {};

      # https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md
      trailspace = {};

      # https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-misc.md
      misc = {};

      # https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
      surround = {};
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>cc";
      action = "<cmd>lua MiniTrailspace.trim()<cr>";
      options = {
        desc = "Remove all trailing whitespaces from the buffer";
      };
    }
  ];
}
