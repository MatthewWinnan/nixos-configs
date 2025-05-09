# DOCS -> https://github.com/someone-stole-my-name/yaml-companion.nvim
# Not working due to E5108: Error executing lua ...lugin-yaml-companion-0.1.3/lua/yaml-companion/config.lua:4: module 'lspconfig.util' not found:
{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "yaml-companion";
        version = "0.1.3";
        src = pkgs.fetchFromGitHub {
          owner = "someone-stole-my-name";
          repo = "yaml-companion.nvim";
          rev = "d190d6c0852a1b3fd2798cf1529655f7f68655d3";
          hash = "sha256-iNne5PR59YWb98Z6HsirIbGk4up45IUWmQPBZ6srZOc=";
        };
      })
    ];

    extraPackages = [pkgs.vimPlugins.nvim-lspconfig];
  };

  programs.nixvim.extraConfigLua = ''
    local yaml_companion_cfg = require("yaml-companion").setup({})
    require("lspconfig")["yamlls"].setup(yaml_companion_cfg)
    require("telescope").load_extension("yaml_schema")
  '';
}
