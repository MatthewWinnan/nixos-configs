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
          clangd = {
            enable = true;
            extraOptions.cmd = [
              "clangd"
              "--query-driver=/nix/store/*/bin/arm-none-eabi-*"
            ];
          };
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

          texlab = {
            enable = true;
            settings.texlab = {
              build =
                if config.systemSettings.profile == "work"
                then {
                  # Work: latexmk is guaranteed via per-project nix shells (texlive.combine)
                  executable = "latexmk";
                  args = ["-pdf" "-interaction=nonstopmode" "-synctex=1" "%f"];
                  onSave = true;
                  forwardSearchAfter = true;
                }
                else {
                  # Personal/Gaming: tectonic is system-wide, no shell needed
                  executable = "tectonic";
                  args = ["-X" "compile" "--synctex" "--keep-logs" "%f"];
                  onSave = true;
                  forwardSearchAfter = true;
                };
              forwardSearch = {
                executable = "sioyek";
                args = [
                  "--reuse-window"
                  "--forward-search-file"
                  "%f"
                  "--forward-search-line"
                  "%l"
                  "%p"
                ];
              };
              chktex = {
                onOpenAndSave = true;
                onEdit = false;
              };
            };
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

            nginx_language_server.enable = true;

            # RobotCode LSP - not packaged in nixpkgs, uses project .venv
            # Install in project: uv pip install robotcode[languageserver] robotframework-robocop
            # Robocop integration is automatic when robocop is in the same Python env
            robotcode = {
              enable = true;
              package = null;
              cmd = ["robotcode" "language-server"];
              settings = {
                robotcode.analysis.diagnosticMode = "openFilesOnly";
              };
            };
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
