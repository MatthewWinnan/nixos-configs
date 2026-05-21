# Helix editor configuration
# Emulates nvim workflow using Helix's built-in features
#
# Plugin mapping (nvim → helix built-in):
#   telescope.nvim       → built-in pickers (file, buffer, symbol, grep)
#   flash.nvim           → built-in jump_to_label (gw)
#   mini.surround        → built-in surround (ms/md/mr)
#   mini.ai              → built-in textobjects (mif, mia, etc.)
#   neo-tree.nvim        → built-in file picker + :open/:explorer
#   lspsaga.nvim         → built-in LSP (gd, gr, K, space+a, space+r)
#   nvim-cmp             → built-in completion (C-x menu)
#   conform.nvim         → built-in auto-format
#   gitsigns.nvim        → built-in diff gutters
#   treesitter           → built-in tree-sitter (highlighting, textobjects, indent)
#   nvim-dap             → built-in DAP (space+g debug menu)
#   trouble.nvim         → built-in diagnostics picker
#   toggleterm.nvim      → shell command (:sh) or terminal multiplexer
#   bufferline.nvim      → built-in bufferline = "multiple"
#   lualine.nvim         → built-in statusline (configurable sections)
#   which-key.nvim       → built-in key popup (auto after timeout)
#   hlchunk/indentscope  → built-in indent-guides
#   comment.nvim         → built-in toggle comment (C-c in normal, gc deprecated)
#   autopairs            → built-in auto-pairs
#   undotree             → built-in :earlier/:later + undo persistence (not visual)
#   harpoon              → ❌ no equivalent (use buffer picker)
#   noice.nvim           → ❌ no equivalent (messages inline)
#   image.nvim           → ❌ no equivalent
{
  config,
  lib,
  pkgs,
  ...
}: {
  config.programs.helix = {
    enable = true;
    defaultEditor = false; # nvim remains default

    settings = {
      editor = {
        # ── Options (matching nixvim opts.nix) ──────────────────────────────
        scrolloff = 12;
        mouse = true;
        line-number = "relative";
        cursorline = false;
        color-modes = true;
        true-color = true;
        undercurl = true;
        bufferline = "multiple"; # bufferline.nvim equivalent
        text-width = 120;
        default-line-ending = "lf";
        rulers = [];
        idle-timeout = 50; # updatetime = 50

        # ── Cursor (visual feedback like nvim modes) ────────────────────────
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        # ── File picker (telescope.nvim equivalent) ─────────────────────────
        file-picker = {
          hidden = false; # show dotfiles
          git-ignore = true;
          git-global = true;
        };

        # ── Statusline (lualine.nvim equivalent) ────────────────────────────
        statusline = {
          left = ["mode" "spinner" "file-name" "file-modification-indicator" "read-only-indicator"];
          center = ["diagnostics" "workspace-diagnostics"];
          right = ["selections" "register" "position" "file-encoding" "file-line-ending" "file-type" "version-control"];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        # ── LSP (lspsaga + lsp.nix equivalent) ─────────────────────────────
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
          auto-signature-help = true;
          snippets = true;
        };

        # ── Indent guides (hlchunk.nvim equivalent) ─────────────────────────
        indent-guides = {
          render = true;
          character = "│";
          skip-levels = 1;
        };

        # ── Gutters (signcolumn = "yes" equivalent) ─────────────────────────
        gutters = ["diagnostics" "spacer" "line-numbers" "spacer" "diff"];

        # ── Soft wrap (wrap = false equivalent) ─────────────────────────────
        soft-wrap.enable = false;

        # ── Whitespace ──────────────────────────────────────────────────────
        whitespace.render = {
          space = "none";
          tab = "all";
          nbsp = "all";
          nnbsp = "all";
          newline = "none";
        };

        # ── Search (smartcase + incsearch equivalent) ───────────────────────
        search = {
          smart-case = true;
          wrap-around = true;
        };

        # ── Auto-pairs (autopairs.nvim equivalent) ──────────────────────────
        auto-pairs = true;

        # ── Auto-save (on focus lost) ──────────────────────────────────────
        auto-save = {
          focus-lost = true;
          after-delay.enable = false;
        };

        # ── Completion (nvim-cmp equivalent) ────────────────────────────────
        completion-trigger-len = 1;
      };

      # ════════════════════════════════════════════════════════════════════════
      # KEYBINDINGS
      # ════════════════════════════════════════════════════════════════════════

      keys.normal = {
        # ── Basic operations (matching keymaps.nix) ─────────────────────────
        "C-s" = ":write"; # save
        "C-x" = ":buffer-close"; # close buffer
        "C-c" = "goto_last_accessed_file"; # alternate file (C-c = :b#)

        # ── Window resize (C-Arrow in nvim) ─────────────────────────────────
        "C-up" = "jump_view_up";
        "C-down" = "jump_view_down";
        "C-left" = "jump_view_left";
        "C-right" = "jump_view_right";

        # ── Move lines (Alt-j/k in nvim) ───────────────────────────────────
        "A-j" = ["extend_to_line_bounds" "delete_selection" "paste_after"];
        "A-k" = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];

        # ── Flash.nvim equivalent (jump_to_label) ───────────────────────────
        # Helix has built-in word jump labels
        "g" = {
          "w" = "jump_to_label"; # like flash jump
          "d" = "goto_definition"; # gd (lspsaga)
          "D" = "goto_declaration"; # gD
          "r" = "goto_reference"; # gr (lspsaga finder ref)
          "I" = "goto_implementation"; # gI (lspsaga finder imp)
          "T" = "goto_type_definition"; # gT (lspsaga peek_type_definition)
          "l" = "goto_last_line"; # G in vim
        };

        # ── G for last line (vim compat) ────────────────────────────────────
        "G" = "goto_last_line";

        # ── Diagnostics navigation ([d ]d from lspsaga) ────────────────────
        "]" = {d = "goto_next_diag"; D = "goto_last_diag";};
        "[" = {d = "goto_prev_diag"; D = "goto_first_diag";};

        # ── Space leader ────────────────────────────────────────────────────
        space = {
          # ── Telescope equivalents (leader+t*) ─────────────────────────────
          t = {
            f = "file_picker"; # <leader>tf find files
            b = "buffer_picker"; # <leader>tb buffers
            r = "global_search"; # <leader>tr live grep
            e = "file_picker_in_current_buffer_directory"; # <leader>te file browser
            j = "jumplist_picker"; # jump list
            s = "symbol_picker"; # document symbols
            S = "workspace_symbol_picker"; # workspace symbols
          };

          # ── Diagnostics (leader+d* — matches helix default) ──────────────
          d = "diagnostics_picker"; # <leader>d show buffer diagnostics
          D = "workspace_diagnostics_picker"; # <leader>D workspace diagnostics

          # ── DAP/Debug (leader+sd* — special debugging) ───────────────────
          s = {
            h = "command_palette"; # <leader>sh help
            s = "symbol_picker"; # symbols
            S = "workspace_symbol_picker"; # workspace symbols
            r = "global_search"; # search and replace (grug-far equivalent)
            d = {
              b = "dap_toggle_breakpoint"; # toggle breakpoint
              c = "dap_continue"; # continue/start
              s = "dap_step_in"; # step in
              n = "dap_step_over"; # step over (next)
              o = "dap_step_out"; # step out
              t = "dap_terminate"; # terminate
              r = "dap_restart"; # restart
              l = "dap_launch"; # launch
              e = "dap_edit_condition"; # conditional breakpoint
              v = "dap_variables"; # inspect variables
            };
          };

          # ── Code actions (leader+c* from lspsaga) ────────────────────────
          c = {
            a = "code_action"; # <leader>ca
            r = "rename_symbol"; # <leader>cr
            w = "symbol_picker"; # <leader>cw outline
            c = ":reflow"; # trim trailing (mini.trailspace)
            f = "format_selections"; # format
          };

          # ── Git (leader+g* from gitsigns/diffview) ───────────────────────
          g = {
            s = "changed_file_picker"; # <leader>gs git status
            d = ":pipe-to git diff"; # diff current file
          };

          # ── File explorer (neo-tree leader+nt) ────────────────────────────
          n = {
            t = "file_picker_in_current_buffer_directory";
          };

          # ── Buffer operations (leader+b*) ─────────────────────────────────
          b = {
            d = ":buffer-close";
            n = ":buffer-next";
            p = ":buffer-previous";
            o = ":buffer-close-others"; # close all other buffers
          };

          # ── Window/split management (leader+w*) ──────────────────────────
          w = {
            v = "vsplit";
            s = "hsplit";
            q = ":quit";
            o = ":only"; # close all other splits
          };

          # ── Format (leader+f from conform) ────────────────────────────────
          f = "format_selections";

          # ── Undo (leader+u from undotree) ─────────────────────────────────
          u = ":earlier";

          # ── Quit ──────────────────────────────────────────────────────────
          q = ":quit";
          Q = ":quit!";
        };

        # ── Surround (mini.surround gs* prefix) ────────────────────────────
        # Helix built-in: ms = add surround, md = delete surround, mr = replace surround
        # These match the default helix surround commands (match mode)
      };

      keys.select = {
        # Move selected lines (visual K/J in nvim)
        "A-j" = ["extend_to_line_bounds" "delete_selection" "paste_after"];
        "A-k" = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];

        # Surround in select mode
        "s" = "surround_add"; # select text then s to surround
      };

      keys.insert = {
        # Save from insert mode (C-s)
        "C-s" = ["normal_mode" ":write"];
        # Completion navigation
        "C-n" = "completion";
        "C-p" = "completion";
      };
    };

    # ══════════════════════════════════════════════════════════════════════════
    # LANGUAGES (matching lsp.nix + conform.nix + dap.nix)
    # ══════════════════════════════════════════════════════════════════════════

    languages = {
      language-server = {
        nil = {
          command = "nil";
          config.nil.formatting.command = ["alejandra"];
        };
        pyright = {
          command = "pyright-langserver";
          args = ["--stdio"];
        };
        ruff = {
          command = "ruff";
          args = ["server"];
        };
        clangd = {
          command = "clangd";
          args = ["--query-driver=/nix/store/*/bin/arm-none-eabi-*"];
        };
        rust-analyzer = {
          command = "rust-analyzer";
        };
        yaml-language-server = {
          command = "yaml-language-server";
          args = ["--stdio"];
        };
        texlab = {
          command = "texlab";
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "alejandra";
          language-servers = ["nil"];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = ["pyright" "ruff"];
          formatter.command = "black";
          formatter.args = ["-" "--quiet"];
          indent = {tab-width = 4; unit = "    ";};
          debugger = {
            name = "debugpy";
            transport = "stdio";
            command = "python";
            args = ["-m" "debugpy.adapter"];
            templates = [
              {
                name = "source";
                request = "launch";
                completion = [{name = "entrypoint"; completion = "filename";}];
                args = {mode = "debug"; program = "{0}";};
              }
            ];
          };
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = ["rust-analyzer"];
          # DAP: uses lldb-dap (built-in default)
        }
        {
          name = "c";
          auto-format = true;
          language-servers = ["clangd"];
          indent = {tab-width = 2; unit = "  ";};
          debugger = {
            name = "lldb-dap";
            transport = "stdio";
            command = "lldb-dap";
            templates = [
              {
                name = "binary";
                request = "launch";
                completion = [{name = "binary"; completion = "filename";}];
                args = {program = "{0}";};
              }
              {
                name = "attach";
                request = "attach";
                completion = [{name = "pid"; completion = "directory";}];
                args = {pid = "{0}";};
              }
            ];
          };
        }
        {
          name = "cpp";
          auto-format = true;
          language-servers = ["clangd"];
          indent = {tab-width = 2; unit = "  ";};
          debugger = {
            name = "lldb-dap";
            transport = "stdio";
            command = "lldb-dap";
            templates = [
              {
                name = "binary";
                request = "launch";
                completion = [{name = "binary"; completion = "filename";}];
                args = {program = "{0}";};
              }
            ];
          };
        }
        {
          name = "yaml";
          auto-format = true;
          language-servers = ["yaml-language-server"];
          formatter.command = "yamlfmt";
          formatter.args = ["-"];
        }
        {
          name = "latex";
          auto-format = true;
          language-servers = ["texlab"];
        }
        {
          name = "html";
          auto-format = true;
          formatter.command = "prettierd";
          formatter.args = ["--parser" "html"];
        }
        {
          name = "css";
          auto-format = true;
          formatter.command = "prettierd";
          formatter.args = ["--parser" "css"];
        }
        {
          name = "javascript";
          auto-format = true;
          formatter.command = "prettierd";
          formatter.args = ["--parser" "babel"];
        }
        {
          name = "typescript";
          auto-format = true;
          formatter.command = "prettierd";
          formatter.args = ["--parser" "typescript"];
        }
        {
          name = "markdown";
          auto-format = true;
          formatter.command = "prettierd";
          formatter.args = ["--parser" "markdown"];
        }
      ];
    };
  };
}
