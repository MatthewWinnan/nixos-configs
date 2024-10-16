{
  programs.nixvim.plugins.barbar = {
    enable = false;
    keymaps = {
      # Keymaps will be silent anyways. This option has always been useless. Should not be enabled
      #silent = true;

      #next = "<TAB>";
      #previous = "<S-TAB>";
      # close = "<C-q>";
    };
  };
}
