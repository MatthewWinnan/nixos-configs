# https://github.com/3rd/image.nvim
{ pkgs, ... }:
{
  programs.nixvim.plugins.image = {
    enable = true;
    settings = {
      backend = "kitty"; # Kitty graphics protocol — supported by kitty, ghostty, and wezterm
      processor = "magick_cli";
    };
  };
}
