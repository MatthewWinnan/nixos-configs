# https://github.com/jbyuki/nabla.nvim
# Renders LaTeX math as Unicode in the buffer (virtual text overlay)
# Better than conceallevel alone — handles complex expressions like fractions, sums, integrals
# Works in .tex files and markdown code blocks
{
  programs.nixvim = {
    plugins.nabla.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>mn";
        action = "<cmd>lua require('nabla').popup()<cr>";
        options.desc = "Nabla: popup math preview";
      }
      {
        mode = "n";
        key = "<leader>mt";
        action = "<cmd>lua require('nabla').toggle_virt({autogen = true, silent = true})<cr>";
        options.desc = "Nabla: toggle inline math";
      }
    ];
  };
}
