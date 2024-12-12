{ config, pkgs, lib, ... }: {
  programs.nixvim.plugins = {

    hmts.enable = true;

    lsp-format = {
      enable = true;
    };

    lsp = {
      enable = true;
      servers = lib.recursiveUpdate {
      # We use the updated version
      nil-ls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      nginx-language-server.enable = true;
      pylsp.enable = true;
      yamlls.enable = true;

      }
        (lib.mkIf (config.systemSettings.profile == "work") {
        # Additional servers for "work" profile
        dockerls.enable = true;
        docker-compose-language-service = {
            enable = true;
            filetypes = [
              "yaml.docker-compose"
              "docker-compose.yaml"
            ];
            };

        # This says it is included https://nix-community.github.io/nixvim/plugins/lsp/servers/robotframework_ls/index.html#robotframework_ls
        # However I can not install it since it is listed as unpackeged on https://github.com/nix-community/nixvim/blob/7d882356a486cf44b7fab842ac26885ecd985af3/plugins/lsp/lsp-packages.nix#L20
        # robotframework_ls.enable = true;

         });

       keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
    };
  };

programs.nixvim.extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';

}
