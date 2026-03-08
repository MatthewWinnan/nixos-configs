#https://github.com/3rd/image.nvim
{
  programs.nixvim.plugins.image = {
    enable = true;
    settings = {
      backend = "kitty";
    };
  };
}
