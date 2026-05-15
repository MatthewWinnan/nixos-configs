# Docs -> https://github.com/greggh/claude-code.nvim
# https://nix-community.github.io/nixvim/plugins/claude-code/index.html
{ pkgs, config, lib, ... }: {
  programs.nixvim.dependencies.claude-code.package = lib.mkIf
    (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming")
    pkgs.claude-code;

  programs.nixvim.plugins.claude-code = {
    enable = config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming";
    settings = {
      window = {
        position = "vertical";
        split_ratio = 0.4;
      };
    };
  };

  programs.nixvim.keymaps = lib.mkIf
    (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming")
    [
      {
        mode = "n";
        key = "<leader>ac";
        action = "<cmd>ClaudeCode<CR>";
        options.desc = "Toggle Claude Code";
      }
    ];
}
