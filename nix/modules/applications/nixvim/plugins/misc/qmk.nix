# DOCS ->  https://github.com/codethread/qmk.nvim/
# DOCS -> https://nix-community.github.io/nixvim/plugins/qmk/settings/index.html

{pkgs, ...}:
{
  programs.nixvim.plugins.qmk = {
    enable = true;
  };
}
