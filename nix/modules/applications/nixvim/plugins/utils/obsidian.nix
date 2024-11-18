# DOCS -> https://github.com/epwalsh/obsidian.nvim
{ lib, config, ... }:
{
  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      completion = {
        min_chars = 2;
        nvim_cmp = true;
      };
      new_notes_location = "current_dir";
      workspaces = [
        {
          name = "personal";
          path = "~/obsidian_vault/matthew_notes";
        }
        {
          name = "work";
          path = "~/DEV/obsidian_vault";
        }
      ];
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
