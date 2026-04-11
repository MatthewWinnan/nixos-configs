{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = false;
    settings = {
      updateInInsert = false;
    };
    sources = {
      diagnostics = {
        # mypy.enable = true;
        statix.enable = true;
      };
    };
  };
}
