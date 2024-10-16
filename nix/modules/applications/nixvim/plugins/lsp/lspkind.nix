# Docs -> https://github.com/onsails/lspkind.nvim
{
  programs.nixvim.plugins.lspkind = {
    enable = true;
    symbolMap = {
      Copilot = "";
    };
    extraOptions = {
      maxwidth = 50;
      ellipsis_char = "...";
    };
  };
}
