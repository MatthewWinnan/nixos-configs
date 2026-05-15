{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      preset = "helix";
      delay = 200;
      notify = true;
      triggers = [
        {
          __unkeyed-1 = "<auto>";
          mode = "nxsot";
        }
      ];
      plugins = {
        marks = true;
        registers = true;
        spelling = {
          enabled = true;
          suggestions = 20;
        };
        presets = {
          operators = true;
          motions = true;
          text_objects = true;
          windows = true;
          nav = true;
          z = true;
          g = true;
        };
      };
      win = {
        no_overlap = true;
        padding = [1 2];
        title = true;
        title_pos = "center";
        zindex = 1000;
      };
      layout = {
        width = {
          min = 20;
        };
        spacing = 3;
      };
      icons = {
        breadcrumb = "»";
        separator = "➜";
        group = "+";
        ellipsis = "…";
        mappings = true;
        colors = true;
        keys = {
          Up = " ";
          Down = " ";
          Left = " ";
          Right = " ";
          C = "󰘴 ";
          M = "󰘵 ";
          D = "󰘳 ";
          S = "󰘶 ";
          CR = "󰌑 ";
          Esc = "󱊷 ";
          ScrollWheelDown = "󱕐 ";
          ScrollWheelUp = "󱕑 ";
          NL = "󰌑 ";
          BS = "󰁮";
          Space = "󱁐 ";
          Tab = "󰌒 ";
          F1 = "󱊫";
          F2 = "󱊬";
          F3 = "󱊭";
          F4 = "󱊮";
          F5 = "󱊯";
          F6 = "󱊰";
          F7 = "󱊱";
          F8 = "󱊲";
          F9 = "󱊳";
          F10 = "󱊴";
          F11 = "󱊵";
          F12 = "󱊶";
        };
      };
      sort = ["local" "order" "group" "alphanum" "mod"];
      expand = 0;
      show_help = true;
      show_keys = true;
      spec = [
        {
          __unkeyed-1 = "<leader>a";
          group = "AI/Session";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffer";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "Code";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "Debug/Diagnostics";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "Find/File";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>gh";
          group = "Hunks/History";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>h";
          group = "Harpoon";
          icon = "󰛢 ";
        }
        {
          __unkeyed-1 = "<leader>m";
          group = "Markdown";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>n";
          group = "Notifications/Tree";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>r";
          group = "Rename";
          icon = "󰑕 ";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "Search/Replace";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "Terminal/Toggle";
          icon = " ";
        }
        {
          __unkeyed-1 = "<leader>u";
          group = "Undo";
          icon = "󰕌 ";
        }
        {
          __unkeyed-1 = "<leader>v";
          group = "Vimade";
          icon = "󰈈 ";
        }
        {
          __unkeyed-1 = "[";
          group = "Prev";
        }
        {
          __unkeyed-1 = "]";
          group = "Next";
        }
        {
          __unkeyed-1 = "g";
          group = "Goto";
        }
        {
          __unkeyed-1 = "gs";
          group = "Surround";
        }
        {
          __unkeyed-1 = "z";
          group = "Fold/Spelling";
        }
      ];
    };
  };
}
