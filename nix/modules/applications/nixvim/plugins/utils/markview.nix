# DOCS -> https://github.com/OXY2DEV/markview.nvim
# I am getting this, clearly there is some dependencies...., deactivate for now
# E5108: Error executing lua ...-vimplugin-markview.nvim-1.0.0/lua/markview/renderer.lua:2: module 'nvim-web-devicons' not found:

{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin rec {
      pname = "markview.nvim";
      version = "1.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "OXY2DEV";
        repo = "markview.nvim";
        rev = "refs/tags/v${version}";
        hash = "sha256-mhRg/cszW/3oXdC1yvbpCeqWQA9WLW5FvcqGd/wBTnE=";
      };
    })
  ];

  programs.nixvim.extraConfigLua = ''
    require("markview").setup();
  '';
}
