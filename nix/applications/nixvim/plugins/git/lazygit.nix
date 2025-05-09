# Docs -> https://github.com/kdheepak/lazygit.nvim/
{
  programs.nixvim.plugins.lazygit = {
    enable = true;
    settings = {
      config_file_path = [];
      floating_window_border_chars = [
        "╭"
        "─"
        "╮"
        "│"
        "╯"
        "─"
        "╰"
        "│"
      ];
      floating_window_scaling_factor = 0.9;
      floating_window_use_plenary = 0;
      floating_window_winblend = 0;
      use_custom_config_file_path = 0;
      use_neovim_remote = 1;
    };
  };

  programs.nixvim.extraConfigLua = ''
    require("telescope").load_extension("lazygit")
  '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options = {
        desc = "LazyGit (root dir)";
      };
    }
  ];
}
