# DOCS -> https://github.com/isakbm/gitgraph.nvim
{pkgs, ...}: {
  programs.nixvim.extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "gitgraph-nvim";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "isakbm";
        repo = "gitgraph.nvim";
        rev = "c16daa7d7dd597caf9085644c009cfa80b75db8e";
        hash = "sha256-QQcqLUJIligXW9bGQR1sDmg9efNFuTWQGCk7E9ni8Tc=";
      };
    })
  ];

  programs.nixvim.extraConfigLua = ''
    require('gitgraph').setup({
      symbols = {
        merge_commit = 'M',
        commit = '*',
      },
      format = {
        timestamp = '%H:%M:%S %d-%m-%Y',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      hooks = {
        on_select_commit = function(commit)
          vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
          vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
        end,
        on_select_range_commit = function(from, to)
          vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
          vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
        end,
      },
    })
  '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gl";
      action.__raw = ''
        function()
          require('gitgraph').draw({}, { all = true, max_count = 5000 })
        end
      '';
      options.desc = "GitGraph: Draw";
    }
  ];
}
