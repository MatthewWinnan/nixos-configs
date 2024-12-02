# DOCS -> https://github.com/AckslD/muren.nvim/

{pkgs, ...}:
{
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "muren";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "AckslD";
        repo = "muren.nvim";
        rev = "818c09097dba1322b2ca099e35f7471feccfef93";  # Use the branch name, or you can specify a specific commit hash
        hash = "sha256-KDXytsyvUQVZoKdr6ieoUE3e0v5NT2gf3M1d15aYVFs=";
      };
    })
  ];

  programs.nixvim.extraConfigLua = ''
    require('muren').setup{}
    '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>mt";
      action = "<cmd>MurenToggle<cr>";
      options.desc = "Neovim plugin for doing multiple search and replace with ease.";
    }
  ];

}
