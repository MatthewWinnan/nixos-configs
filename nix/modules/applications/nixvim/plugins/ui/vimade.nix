# vimade is not out on nixvim
# DOCS -> https://github.com/TaDaa/vimade
{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "vimade.nvim";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "TaDaa";
        repo = "vimade";
        rev = "cde9665d44225d9eb40007780211d1bb9dc2f19f";  # Use the branch name, or you can specify a specific commit hash
        hash = "sha256-wEDZGwsfO/jYObTulUNeVHxd0mgGinKpBsAEz7jjmrA=";
      };
    })
  ];

  # We just do the minimalist config
  programs.nixvim.extraConfigLua = ''
    local Minimalist = require('vimade.recipe.minimalist').Minimalist
    require('vimade').setup(Minimalist{animate = true})
  '';

  # Just include some toggle options
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>vt";
      action = "<cmd>VimadeToggle<cr>";
      options = {
        desc = "Toggles the activity of Vimade";
      };
    }
  ];

}
