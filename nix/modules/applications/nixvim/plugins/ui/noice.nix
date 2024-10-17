# Docs -> https://github.com/folke/noice.nvim
{
  programs.nixvim.plugins.noice = {
    enable = true;
    notify = {
      enabled = false;
    };
    messages = {
      enabled = true; # Adds a padding-bottom to neovim statusline when set to false for some reason
    };
    lsp = {
      message = {
        enabled = true;
      };
      progress = {
        enabled = true;
        view = "mini";
      };
    };
    popupmenu = {
      enabled = true;
      backend = "nui";
    };
    format = {
      filter = {
        pattern = [
          ":%s*%%s*s:%s*"
          ":%s*%%s*s!%s*"
          ":%s*%%s*s/%s*"
          "%s*s:%s*"
          ":%s*s!%s*"
          ":%s*s/%s*"
        ];
        icon = "";
        lang = "regex";
      };
      replace = {
        pattern = [
          ":%s*%%s*s:%w*:%s*"
          ":%s*%%s*s!%w*!%s*"
          ":%s*%%s*s/%w*/%s*"
          "%s*s:%w*:%s*"
          ":%s*s!%w*!%s*"
          ":%s*s/%w*/%s*"
        ];
        icon = "󱞪";
        lang = "regex";
      };
    };
  };
}
