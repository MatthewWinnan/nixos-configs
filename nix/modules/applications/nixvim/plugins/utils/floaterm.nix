{
  programs.nixvim.plugins.floaterm = {
    enable = true;

    settings = {
      title = "";
      height = 0.8;
      width = 0.8;
      keymaps.toggle = "<C-b>";
    };

  };
}
