# DOCS -> https://github.com/mfussenegger/nvim-dap
#         https://github.com/rcarriga/nvim-dap-ui
#         https://github.com/theHamsta/nvim-dap-virtual-text
{pkgs, ...}: {
  programs.nixvim.plugins = {
    dap = {
      enable = true;

      adapters = {
        executables = {
          debugpy = {
            command = "${pkgs.python3Packages.debugpy}/bin/python";
            args = ["-m" "debugpy.adapter"];
          };
        };
        servers = {
          codelldb = {
            port = 13000;
            executable = {
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              args = ["--port" "13000"];
            };
          };
        };
      };

      configurations = {
        python = [
          {
            name = "Launch file";
            type = "debugpy";
            request = "launch";
            program.__raw = "function() return vim.fn.expand('%:p') end";
            cwd.__raw = "vim.fn.getcwd";
            justMyCode = false;
          }
          {
            name = "Launch file (single thread)";
            type = "debugpy";
            request = "launch";
            program.__raw = "function() return vim.fn.expand('%:p') end";
            cwd.__raw = "vim.fn.getcwd";
            justMyCode = false;
            # Only stops the thread that hit the breakpoint, others keep running
            stopOnEntry = false;
            rules = [{ module = "*"; include = true; }];
          }
        ];
        rust = [
          {
            name = "Launch";
            type = "codelldb";
            request = "launch";
            program.__raw = ''
              function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
              end
            '';
            cwd.__raw = "vim.fn.getcwd";
            stopOnEntry = false;
          }
        ];
        c = [
          {
            name = "Launch";
            type = "codelldb";
            request = "launch";
            program.__raw = ''
              function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end
            '';
            cwd.__raw = "vim.fn.getcwd";
            stopOnEntry = false;
          }
        ];
        cpp = [
          {
            name = "Launch";
            type = "codelldb";
            request = "launch";
            program.__raw = ''
              function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end
            '';
            cwd.__raw = "vim.fn.getcwd";
            stopOnEntry = false;
          }
        ];
      };
    };

    dap-ui = {
      enable = true;
    };

    dap-virtual-text = {
      enable = true;
    };
  };

  # Auto open/close dap-ui when debugging starts/stops
  programs.nixvim.extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
  '';

  programs.nixvim.keymaps = [
    { mode = "n"; key = "<leader>dc"; action = "<cmd>DapContinue<cr>";          options.desc = "Debug: Continue/Launch"; }
    { mode = "n"; key = "<leader>do"; action = "<cmd>DapStepOver<cr>";          options.desc = "Debug: Step over"; }
    { mode = "n"; key = "<leader>di"; action = "<cmd>DapStepInto<cr>";          options.desc = "Debug: Step into"; }
    { mode = "n"; key = "<leader>dO"; action = "<cmd>DapStepOut<cr>";           options.desc = "Debug: Step out"; }
    { mode = "n"; key = "<leader>db"; action = "<cmd>DapToggleBreakpoint<cr>";  options.desc = "Debug: Toggle breakpoint"; }
    { mode = "n"; key = "<leader>dq"; action = "<cmd>DapTerminate<cr>";         options.desc = "Debug: Terminate"; }
    { mode = "n"; key = "<leader>du"; action.__raw = "function() require('dapui').toggle() end"; options.desc = "Debug: Toggle UI"; }
    { mode = "n"; key = "<leader>dB"; action.__raw = "function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end"; options.desc = "Debug: Conditional breakpoint"; }
  ];
}
