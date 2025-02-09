# DOCS -> https://github.com/nvim-lua/plenary.nvim

{pkgs, ...}:
{
  programs.nixvim.plugins.plenary.enable = true;
  # programs.nixvim.extraPlugins = with pkgs.vimUtils; [
  #   (buildVimPlugin rec {
  #     pname = "plenary";
  #     version = "0.1.4";
  #     src = pkgs.fetchFromGitHub {
  #       owner = "nvim-lua";
  #       repo = "plenary.nvim";
  #       rev = "refs/tags/v${version}";
  #       hash = "sha256-zR44d9MowLG1lIbvrRaFTpO/HXKKrO6lbtZfvvTdx+o=";
  #     };
  #   })
  # ];
  #
  # programs.nixvim.extraConfigLua = ''
  #   require('plenary').setup{}
  #   '';

}
