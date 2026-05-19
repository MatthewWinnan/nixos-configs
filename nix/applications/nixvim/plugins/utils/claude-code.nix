# Docs -> https://github.com/greggh/claude-code.nvim
# https://nix-community.github.io/nixvim/plugins/claude-code/index.html
{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming";
in {
  programs.nixvim = {
    dependencies.claude-code.package = lib.mkIf enabled pkgs.claude-code;

    plugins.claude-code = {
      enable = enabled;
      settings = {
        window = {
          position = "vertical";
          split_ratio = 0.4;
        };
      };
    };

    keymaps = lib.mkIf enabled [
      {
        mode = "n";
        key = "<leader>ac";
        action = "<cmd>ClaudeCode<CR>";
        options.desc = "Toggle Claude Code";
      }
    ];
  };
}
