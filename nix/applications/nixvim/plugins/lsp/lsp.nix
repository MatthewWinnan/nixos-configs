{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    hmts.enable = true;

    lsp-format = {
      enable = true;
    };

    lsp = {
      enable = true;
      servers =
        lib.recursiveUpdate {
          # We use the updated version
          nil_ls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          nginx_language_server.enable = true;

          #pylsp.enable = true;

          # Pyright DOCS -> https://microsoft.github.io/pyright/#/configuration
          pyright = {
            enable = true;
            settings = {
              typeCheckingMode = "off";
              reportAttributeAccessIssue = "none";
              reportArgumentType = "none";
            };
          };

          ruff.enable = true;

          yamlls.enable = true;

          # Rember the docs here, important to get running correctly, the compile commands will be handled by my dev shells
          # https://nix-community.github.io/nixvim/plugins/lsp/servers/clangd/index.html#clangd
          clangd.enable = true;
          cmake.enable = true;

          # For my RUST adventures
          # NB I ensure that rustup, rustc and cargo are in my environment
          # in order to silence the warnings I disable here, enable to ensure it is
          # with main NixOS
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        }
        (
          if config.systemSettings.profile == "work"
          then {
            # Additional servers for "work" profile
            dockerls.enable = true;
            docker_compose_language_service = {
              enable = true;
              filetypes = [
                "yaml.docker-compose"
                "docker-compose.yaml"
              ];
            };

            # This says it is included https://nix-community.github.io/nixvim/plugins/lsp/servers/robotframework_ls/index.html#robotframework_ls
            # However I can not install it since it is listed as unpackeged on https://github.com/nix-community/nixvim/blob/7d882356a486cf44b7fab842ac26885ecd985af3/plugins/lsp/lsp-packages.nix#L20
            # robotframework_ls.enable = true;
            #robotcode.enable = true;
          }
          else if config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming"
          then {
            # arduino_language_server.enable = true;
          }
          # We need to make sure recursiveUpdate gets a valid alternative if not work
          else {}
        );

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
