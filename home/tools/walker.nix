#
# Walker - Omarchy-inspired application launcher
#
# A Hyprland-native launcher with prefix-based providers
# Prefixes: / (providers), . (files), : (symbols), = (calc), @ (web), $ (clipboard)
#
{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
  tomlFormat = pkgs.formats.toml { };

  layoutToml = tomlFormat.generate "walker-theme-stylix-layout" {
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
          margins.top = 200;
          scroll.list = {
            max_height = 400;
            min_width = 450;
            width = 450;
            margins.top = 8;
            item = {
              icon.pixel_size = 28;
              activation_label = {
                h_align = "fill";
                v_align = "fill";
                width = 20;
                x_align = 0.5;
                y_align = 0.5;
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
            spinner.hide = true;
          };
        };
      };
    };
  };

  styleCss = ''
    * {
      all: unset;
      font-family: monospace;
      font-size: 16px;
      color: #${colors.base05};
    }

    window {
      background-color: transparent;
    }

    .box-wrapper {
      background: #${colors.base00};
      padding: 20px;
      border: 2px solid #${colors.base0D};
      border-radius: 0;
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

    .search-container {
      background: #${colors.base01};
      padding: 12px;
      border-radius: 0;
      border: 1px solid #${colors.base03};
    }

    .input {
      background: transparent;
      caret-color: #${colors.base05};
    }

    .input placeholder {
      opacity: 0.5;
    }

    .input:focus,
    .input:active {
      box-shadow: none;
      outline: none;
    }

    .list {
      background: #${colors.base00};
    }

    child:selected .item-box,
    child:hover .item-box {
      background: #${colors.base02};
      border-radius: 0;
    }

    child:selected .item-box * {
      color: #${colors.base0D};
    }

    .item-box {
      padding: 8px 14px;
      border-radius: 0;
    }

    .item-text-box {
      padding: 6px 0;
    }

    .item-text {
      font-size: 14px;
    }

    .item-subtext {
      font-size: 12px;
      color: #${colors.base04};
    }

    .item-image,
    .item-image-text {
      margin-right: 14px;
    }

    .placeholder,
    .elephant-hint {
      color: #${colors.base05};
      opacity: 0.5;
    }

    .keybinds-wrapper {
      background: #${colors.base01};
      padding: 10px;
      margin-top: 10px;
      border-radius: 0;
      font-size: 12px;
      opacity: 0.5;
    }

    .keybind-bind {
      font-weight: bold;
    }

    .error {
      padding: 10px;
      background: #${colors.base08};
      color: #${colors.base05};
      border-radius: 0;
    }
  '';
in
{
  systemd.user.services.walker = {
    Service.Environment = lib.mkForce (
      [ "GDK_BACKEND=wayland" ]
      ++ lib.optionals (config.systemSettings.profile == "work") [ "LIBGL_ALWAYS_SOFTWARE=1" ]
      ++ lib.optionals (config.systemSettings.profile != "work") [
        "LIBVA_DRIVER_NAME=nvidia"
        "__GLX_VENDOR_LIBRARY_NAME=nvidia"
      ]
    );
    Install.WantedBy = lib.mkForce [ "graphical-session.target" ];
  };

  # Walker 2.x expects themes as directories: themes/<name>/style.css + layout.toml
  # The HM module writes flat files (themes/<name>.css) which is the old format.
  xdg.configFile = {
    "walker/themes/stylix/style.css".text = styleCss;
    "walker/themes/stylix/layout.toml".source = layoutToml;
    "elephant/elephant.toml".text = ''
      terminal_cmd = "ghostty -e"
    '';
  };

  services.walker = {
    enable = true;
    systemd.enable = true;

    # No theme option — we write the files directly above
    settings = {
      theme = "stylix";
      force_keyboard_focus = true;
      selection_wrap = true;
      hide_action_hints = true;

      placeholders = {
        default = {
          input = " Search...";
          list = "No Results";
        };
      };

      keybinds = {
        quick_activate = [ ];
      };

      columns = {
        symbols = 1;
      };


      providers = {
        actions = {
          desktopapplications = [
            {
              action = "start";
              default = true;
              bind = "Return";
            }
            {
              action = "start:keep";
              label = "open+next";
              bind = "shift Return";
              after = "KeepOpen";
            }
          ];
          runner = [
            {
              action = "run";
              default = true;
              bind = "Return";
              after = "Close";
            }
            {
              action = "runterminal";
              label = "run in terminal";
              bind = "shift Return";
              after = "Close";
            }
          ];
        };
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
  };
}
