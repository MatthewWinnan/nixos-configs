# DOCS -> https://github.com/sindrets/diffview.nvim
{
  programs.nixvim.plugins.diffview = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gd";
      action = "<cmd>DiffviewOpen<cr>";
      options.desc = "Diffview: Open diff";
    }
    {
      mode = "n";
      key = "<leader>gh";
      action = "<cmd>DiffviewFileHistory %<cr>";
      options.desc = "Diffview: File history";
    }
    {
      mode = "n";
      key = "<leader>go";
      action.__raw = ''
        function()
          -- Detect the remote's default branch; fall back to origin/main.
          local base = "origin/main"
          local head = vim.fn.systemlist("git symbolic-ref --quiet --short refs/remotes/origin/HEAD")
          if vim.v.shell_error == 0 and head[1] and head[1] ~= "" then
            base = head[1]
          end
          vim.cmd("DiffviewOpen " .. base .. "...HEAD")
        end
      '';
      options.desc = "Diffview: Open MR diff (vs remote default branch)";
    }
    {
      mode = "n";
      key = "<leader>gq";
      action = "<cmd>DiffviewClose<cr>";
      options.desc = "Diffview: Close";
    }
  ];
}
