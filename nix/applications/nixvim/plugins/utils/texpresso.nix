# https://nix-community.github.io/nixvim/plugins/texpresso.html
# https://github.com/let-def/texpresso.vim/
{pkgs, ...}: {
  programs.nixvim.plugins.texpresso = {
    enable = true;
  };
}
