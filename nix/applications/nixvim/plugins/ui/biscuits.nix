# https://github.com/code-biscuits/nvim-biscuits
{pkgs, ...}: {
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin rec {
      pname = "nvim-biscuits.nvim";
      version = "main";
      # Just trust it works?
      # But a lot fails, must things are being looked for in standard paths which this wouldn't cater for
      doCheck = false;
      src = pkgs.fetchFromGitHub {
        owner = "code-biscuits";
        repo = "nvim-biscuits";
        rev = "${version}";
        hash = "sha256-9RYhPZT1Jx380fAugZUlQeDz2vy579V8uC13K8bbu6E=";
      };
    })
  ];

  programs.nixvim.extraConfigLua = ''
      require('nvim-biscuits').setup({
      cursor_line_only = true,
    default_config = {
      max_length = 12,
      min_distance = 5,
      prefix_string = " 🍪 "
    },
    language_config = {
      python = {
        prefix_string = " 🐍 ",
      },
      rust = {
        prefix_string = " 🦀 ",
      },
    },
      }); '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>bt";
      action = "<cmd>lua require('nvim-biscuits').toggle_biscuits()<cr>";
      options = {
        desc = "Toggles Biscuits 🍪";
      };
    }
  ];
}
