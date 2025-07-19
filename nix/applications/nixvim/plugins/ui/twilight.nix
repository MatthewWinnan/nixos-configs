# https://nix-community.github.io/nixvim/plugins/twilight/index.html
# https://github.com/folke/twilight.nvim/
{config, ...}: {
  programs.nixvim.plugins.twilight = {
    enable = true;
    settings = {
      dimming = {
        alpha = 0.3;
        color = [
          "Normal"
          "#ffffff"
        ];
        # Only allow this if we do not have transparent as on;
        # When true, other windows will be fully dimmed (unless they contain the same buffer)
        inactive = !config.programs.nixvim.plugins.transparent.enable;
      };
      context = 15;
      treesitter = true;
      expand = [
        "function"
        "method"
        "table"
        "if_statement"
      ];
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>tT";
      action = "<cmd>Twilight<cr>";
      options = {
        desc = "Toggles Twilight";
      };
    }
  ];
}
