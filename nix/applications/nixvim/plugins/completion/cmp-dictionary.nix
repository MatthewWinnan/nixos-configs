# https://github.com/uga-rosa/cmp-dictionary
# Pre-indexed dictionary completion — loads once at startup, near-zero runtime cost
# Much faster than cmp-buffer scanning all buffers
{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.cmp-dictionary];

    extraConfigLua = ''
      require("cmp_dictionary").setup({
        paths = { "${pkgs.scowl}/share/dict/wbritish.50" },
        exact_length = 2,
        first_case_insensitive = true,
        document = {
          enable = false,
        },
        async = true,
        max_number_items = 10,
      })
    '';
  };
}
