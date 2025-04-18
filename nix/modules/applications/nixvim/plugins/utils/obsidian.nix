# DOCS -> https://github.com/epwalsh/obsidian.nvim
{
  lib,
  config,
  ...
}: {
  programs.nixvim.plugins.obsidian = {
    enable = false;
    settings = {
      completion = {
        min_chars = 2;
        nvim_cmp = true;
      };
      new_notes_location = "current_dir";
      workspaces = [];
      mappings = {
        "<leader>og" = {
          action = "require('obsidian').util.gf_passthrough";
          opts = {
            noremap = false;
            expr = true;
            buffer = true;
          };
        };
        "<leader>oc" = {
          action = "require('obsidian').util.toggle_checkbox";
          opts.buffer = true;
        };
      };
    };
  };
}
