# DOCS -> https://github.com/AckslD/nvim-neoclip.lua/
{
  programs.nixvim.plugins.neoclip = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>nc";
      action = "<cmd>Telescope neoclip sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>";
      options.desc = "Views neoclippy";
    }
    {
      mode = "n";
      key = "<leader>nm";
      action = "<cmd>Telescope macroscope sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>";
      options.desc = "Views macro clipboard";
    }
  ];
}
