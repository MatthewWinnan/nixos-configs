{ config, pkgs, ... }: {
  programs.nixvim.plugins = {

    treesitter = {
      enable = true;
      nixvimInjections = true;
      folding = true;

      # Now in plugins.treesitter.settings.indent.enable
      settings = {
      indent.enable = true;
      };
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;
        # Set to false if you have an `updatetime` of ~100.
        clearOnCursorMove = false;
      };
    };

    hmts.enable = true;

    # lspkind = {
    #   enable = true;
    #
    #   cmp = {
    #     enable = true;
    #     menu = {
    #       nvim_lsp = "[LSP]";
    #       nvim_lua = "[api]";
    #       path = "[path]";
    #       luasnip = "[snip]";
    #       buffer = "[buffer]";
    #       neorg = "[neorg]";
    #       cmp_tabby = "[Tabby]";
    #     };
    #   };
    # };

    lsp = {
      enable = true;
      servers = {
        # We use the updated version
        nil-ls.enable = true;
        tsserver.enable = true;
      };
    };
  };
}
