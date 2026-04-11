# DOCS -> https://github.com/OXY2DEV/markview.nvim
# https://nix-community.github.io/nixvim/plugins/markview/index.html
{
  programs.nixvim.plugins.markview = {
    enable = true;
    settings = {
      preview = {
        icon_provider = "devicons";
        hybrid_modes = ["n" "no"];
        linewise_hybrid_mode = true;
      };
      markdown = {
        headings.enable = true;
        code_blocks.enable = true;
        tables.enable = true;
        list_items.enable = true;
        horizontal_rules.enable = true;
        checkboxes.enable = true;
      };
      latex.enable = true;
      html.enable = true;
      yaml.enable = true;
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>mv";
      action = "<cmd>Markview toggle<cr>";
      options.desc = "Toggle Markview preview";
    }
    {
      mode = "n";
      key = "<leader>ms";
      action = "<cmd>Markview splitToggle<cr>";
      options.desc = "Toggle Markview splitview";
    }
  ];
}
