# DOCS -> https://github.com/gbprod/yanky.nvim
{
  programs.nixvim.plugins.yanky = {
    enable = true;
    settings = {
      ring.history_length = 50;
      highlight.timer = 200;
    };
  };

  programs.nixvim.keymaps = [
    { mode = "n"; key = "<leader>nc"; action = "<cmd>Telescope yank_history<cr>"; options.desc = "Yank history"; }
    { mode = ["n" "x"]; key = "p"; action = "<Plug>(YankyPutAfter)"; options.desc = "Put after"; }
    { mode = ["n" "x"]; key = "P"; action = "<Plug>(YankyPutBefore)"; options.desc = "Put before"; }
    { mode = "n"; key = "<C-p>"; action = "<Plug>(YankyPreviousEntry)"; options.desc = "Cycle yank history back"; }
    { mode = "n"; key = "<C-n>"; action = "<Plug>(YankyNextEntry)"; options.desc = "Cycle yank history forward"; }
  ];
}
