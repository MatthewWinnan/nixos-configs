# DOCS -> https://github.com/SmiteshP/nvim-navic

{
  programs.nixvim.plugins.navic = {
    enable = true;
    settings = {
      lsp = {
        auto_attach = true;
        preference = [];
      };

      icons = {
        File          = "󰈙 ";
        Module        = " ";
        Namespace     = "󰌗 ";
        Package       = " ";
        Class         = "󰌗 ";
        Method        = "󰆧 ";
        Property      = " ";
        Field         = " ";
        Constructor   = " ";
        Enum          = "󰕘";
        Interface     = "󰕘";
        Function      = "󰊕 ";
        Variable      = "󰆧 ";
        Constant      = "󰏿 ";
        String        = "󰀬 ";
        Number        = "󰎠 ";
        Boolean       = "◩ ";
        Array         = "󰅪 ";
        Object        = "󰅩 ";
        Key           = "󰌋 ";
        Null          = "󰟢 ";
        EnumMember    = " ";
        Struct        = "󰌗 ";
        Event         = " ";
        Operator      = "󰆕 ";
        TypeParameter = "󰊄 ";
    };
    };
  };
}