#
# Walker - Omarchy-inspired application launcher
#
# A Hyprland-native launcher with prefix-based providers
# Prefixes: / (providers), . (files), : (symbols), = (calc), @ (web), $ (clipboard)
#
{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  services.walker = {
    enable = true;
    systemd.enable = true;

    settings = {
      force_keyboard_focus = true;
      selection_wrap = true;
      hide_action_hints = true;

      placeholder = {
        input = " Search...";
        list = "No Results";
      };

      keybinds = {
        quick_activate = [];
      };

      columns = {
        symbols = 1;
      };

      terminal = "ghostty -e";

      builtins = {
        runner = {
          enabled = true;
          generic_entry = true;
        };
      };

      actions = {
        runner = [
          { action = "run"; default = true; bind = "Return"; }
          { action = "runterminal"; label = "run in terminal"; bind = "shift Return"; }
        ];
      };

      providers = {
        max_results = 256;
        default = [
          "desktopapplications"
          "websearch"
        ];

        prefixes = [
          {
            prefix = "/";
            provider = "providerlist";
          }
          {
            prefix = ".";
            provider = "files";
          }
          {
            prefix = ":";
            provider = "symbols";
          }
          {
            prefix = "=";
            provider = "calc";
          }
          {
            prefix = "@";
            provider = "websearch";
          }
          {
            prefix = "$";
            provider = "clipboard";
          }
          {
            prefix = "!";
            provider = "runner";
          }
        ];
      };
    };

    theme = {
      name = "stylix";
      layout = {
        ui = {
          anchors = {
            bottom = true;
            left = true;
            right = true;
            top = true;
          };
          window = {
            h_align = "fill";
            v_align = "fill";
            box = {
              h_align = "center";
              width = 500;
              margins = { top = 200; };
              scroll = {
                list = {
                  max_height = 400;
                  min_width = 450;
                  width = 450;
                  margins = { top = 8; };
                  item = {
                    icon = { pixel_size = 28; };
                    activation_label = {
                      h_align = "fill";
                      v_align = "fill";
                      width = 20;
                      x_align = 0.5;
                      y_align = 0.5;
                    };
                  };
                };
              };
              search = {
                prompt = {
                  icon = "edit-find";
                  pixel_size = 18;
                  h_align = "center";
                  v_align = "center";
                };
                input = {
                  h_align = "fill";
                  h_expand = true;
                  icons = true;
                };
                spinner = { hide = true; };
              };
            };
          };
        };
      };
      style = ''
        * {
          font-family: monospace;
          font-size: 16px;
          color: #${colors.base05};
        }

        #window,
        window {
          background-color: transparent;
        }

        #box,
        .outer-box {
          background-color: #${colors.base00};
        }

        scrollbar {
          opacity: 0;
        }

        .normal-icons {
          -gtk-icon-size: 16px;
        }

        .large-icons {
          -gtk-icon-size: 32px;
        }

        #box {
          background: #${colors.base00};
          border: 3px solid #${colors.base0D};
          border-radius: 12px;
        }

        .box-wrapper {
          background: #${colors.base00};
          padding: 20px;
          border: 3px solid #${colors.base0D};
          border-radius: 12px;
        }

        #search {
          background: #${colors.base01};
          padding: 12px;
          border-radius: 8px;
          border: 1px solid #${colors.base03};
        }

        .search-container {
          background: #${colors.base01};
          padding: 12px;
          border-radius: 8px;
          border: 1px solid #${colors.base03};
        }

        #input {
          background: transparent;
        }

        .input placeholder {
          opacity: 0.5;
        }

        .input:focus,
        .input:active {
          box-shadow: none;
          outline: none;
        }

        #list {
          background: #${colors.base00};
        }

        child:selected .item-box {
          background: #${colors.base02};
          border-radius: 6px;
        }

        child:selected .item-box * {
          color: #${colors.base0D};
        }

        .item-box {
          padding: 8px 14px;
        }

        .item-text-box {
          padding: 6px 0;
        }

        .item-subtext {
          font-size: 12px;
          color: #${colors.base04};
        }

        .item-image {
          margin-right: 14px;
          -gtk-icon-transform: scale(0.9);
        }

        .current {
          font-style: italic;
        }

        .keybind-hints {
          background: #${colors.base01};
          padding: 10px;
          margin-top: 10px;
          border-radius: 6px;
        }
      '';
    };
  };
}
