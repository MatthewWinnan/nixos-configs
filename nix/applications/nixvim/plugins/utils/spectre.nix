# https://nix-community.github.io/nixvim/plugins/spectre/index.html
# https://github.com/nvim-pack/nvim-spectre/
{
  programs.nixvim.plugins.spectre = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>st";
      action = "<cmd>lua require('spectre').toggle()<cr>";
      options.desc = "Toggles Spectre 👻";
    }
    {
      mode = "n";
      key = "<leader>sw";
      action = "<cmd>lua require('spectre').open_visual({select_word=true})<cr>";
      options.desc = "Search Current Word 👻";
    }
    {
      mode = "v";
      key = "<leader>sw";
      action = "<esc><cmd>lua require('spectre').open_visual()<cr>";
      options.desc = "Search Current Word 👻";
    }
    {
      mode = "n";
      key = "<leader>sp";
      action = "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>";
      options.desc = "Search Current File 👻";
    }
  ];
}
