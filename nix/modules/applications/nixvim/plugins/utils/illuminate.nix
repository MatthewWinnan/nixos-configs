# https://github.com/RRethy/vim-illuminate
{
  programs.nixvim.plugins.illuminate = {
    enable = true;
    underCursor = false;
    filetypesDenylist = [
      "Outline"
      "TelescopePrompt"
      "alpha"
      "harpoon"
      "reason"
    ];
  };
}
