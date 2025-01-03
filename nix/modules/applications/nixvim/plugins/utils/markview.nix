# DOCS -> https://github.com/OXY2DEV/markview.nvim
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
