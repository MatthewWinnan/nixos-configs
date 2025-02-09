# DOCS -> https://github.com/nvim-tree/nvim-web-devicons

{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin rec {
      pname = "nvim-web-devicons";
      version = "0.100";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-tree";
        repo = "nvim-web-devicons";
        rev = "refs/tags/v${version}";
        hash = "sha256-DSUTxUFCesXuaJjrDNvurILUt1IrO5MI5ukbZ8D87zQ=";
      };
    })
  ];

  programs.nixvim.extraConfigLua = ''
    require("nvim-web-devicons").setup();
  '';
}
