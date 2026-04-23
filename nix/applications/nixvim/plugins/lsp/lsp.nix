{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    hmts.enable = true;

    lsp-format = {
      enable = false;
    };

    lsp = {
      enable = true;
      servers =
        lib.recursiveUpdate
        {
          # We use the updated version
          nil_ls = {
            enable = true;
            settings.nil.formatting.command = ["alejandra"];
          };

          html.enable = true;

          jsonls.enable = true;

          # Pyright DOCS -> https://microsoft.github.io/pyright/#/configuration
          pyright.enable = true;

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

          texlab.enable = true;
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

            nginx_language_server.enable = true;

            # This says it is included https://nix-community.github.io/nixvim/plugins/lsp/servers/robotframework_ls/index.html#robotframework_ls
            # However I can not install it since it is listed as unpackaged on https://github.com/nix-community/nixvim/blob/7d882356a486cf44b7fab842ac26885ecd985af3/plugins/lsp/lsp-packages.nix#L20
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
          # Only gD remains — lspsaga handles gd, gr, gI, gT, K, <leader>cw, <leader>cr
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
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
