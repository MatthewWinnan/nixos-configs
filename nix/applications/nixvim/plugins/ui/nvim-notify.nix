# DOCS -> https://github.com/rcarriga/nvim-notify
# Used as the rendering backend for noice.nvim notifications
{
  programs.nixvim.plugins.notify = {
    enable = true;
    settings = {
      background_colour = "#000000";
      top_down = true;
      fps = 60;
      render = "default";
      timeout = 1000;
    };
  };
}
