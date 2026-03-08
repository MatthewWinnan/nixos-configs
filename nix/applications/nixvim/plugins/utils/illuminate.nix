# https://github.com/RRethy/vim-illuminate
{
  programs.nixvim.plugins.illuminate = {
    enable = true;
    settings = {
      under_cursor = false;
      filetypes_denylist = [
        "Outline"
        "TelescopePrompt"
        "alpha"
        "harpoon"
        "reason"
      ];
    };
  };
}
