{
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      globalstatus = true;

      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+

      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          "filename"
          "diff"
        ];

        lualine_x = [
          "diagnostics"

          # Show active language server
          {
            __raw = ''
              {
                function()
                    local msg = ""
                    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                    local clients = vim.lsp.get_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
                            return client.name
                        end
                    end
                    return msg
                end,
                icon = " ",
              }
            '';
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
      };
    };
  };
}
