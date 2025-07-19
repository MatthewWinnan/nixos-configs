# https://nix-community.github.io/nixvim/plugins/render-markdown/index.html
# https://github.com/MeanderingProgrammer/render-markdown.nvim
{pkgs, ...}: {
  programs.nixvim.plugins.render-markdown = {
    enable = true;
  };
}
