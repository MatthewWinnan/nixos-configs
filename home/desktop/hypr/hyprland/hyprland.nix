# NB Remember do not map ATL-><vim_nav>
{
  config,
  pkgs,
  lib,
  ...
}: let
  last_monitor = lib.lists.last config.deviceSettings.monitors;

  # Format a float cleanly: 60.000000 -> "60", 143.980000 -> "143.98"
  fmtRate = rate: let
    raw = toString rate;
    # Split on the decimal point
    parts = lib.splitString "." raw;
    intPart = builtins.elemAt parts 0;
    # Strip trailing zeros from fractional part
    fracRaw = if builtins.length parts > 1 then builtins.elemAt parts 1 else "";
    fracStripped = lib.strings.removeSuffix "0"
      (lib.strings.removeSuffix "0"
        (lib.strings.removeSuffix "0"
          (lib.strings.removeSuffix "0"
            (lib.strings.removeSuffix "0"
              (lib.strings.removeSuffix "0" fracRaw)))));
  in
    if fracStripped == "" then intPart
    else "${intPart}.${fracStripped}";

  # Helper: generate a lua hl.monitor({...}) call for a single monitor attrset
  monitorToLua = m:
    if m.enabled then ''
      hl.monitor({
        output = "${m.name}",
        mode = "${toString m.width}x${toString m.height}@${fmtRate m.refreshRate}",
        position = "${m.position}",
        scale = 1,
        transform = ${m.rotate_mode},${lib.optionalString (m.bitdepth == 10) ''

        bitdepth = 10,''}
      })
    '' else ''
      hl.monitor({
        output = "${m.name}",
        disabled = true,
      })
    '';

  # Helper: generate workspace rule for a monitor
  workspaceToLua = m:
    lib.optionalString (m.enabled && m.workspace != null) ''
      hl.workspace_rule({ workspace = "${m.workspace}", monitor = "${m.name}", default = true })
    '';

  # Build env vars list as lua calls
  envVarsBase = [
    ''hl.env("XCURSOR_SIZE", "24")''
    ''hl.env("QT_QPA_PLATFORM", "wayland")''
    ''hl.env("XDG_SCREENSHOTS_DIR", "~/Media/Pictures")''
    ''hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")''
    ''hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")''
    ''hl.env("GTK_THEME", "adw-gtk3-dark")''
  ];

  envVarsNvidia = lib.optionals (config.deviceSettings.type != "vm") [
    ''hl.env("LIBVA_DRIVER_NAME", "nvidia")''
    ''hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")''
  ];

  envVarsVM = lib.optionals (config.deviceSettings.type == "vm") [
    ''hl.env("LIBGL_ALWAYS_SOFTWARE", "1")''
    ''hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")''
    ''hl.env("AQ_NO_MODIFIERS", "1")''
    ''hl.env("AQ_MGPU_NO_EXPLICIT", "1")''
  ];

  allEnvVars = envVarsBase ++ envVarsNvidia ++ envVarsVM;

  # Conditional settings based on profile
  isGaming = config.systemSettings.profile == "gaming";
  isWork = config.systemSettings.profile == "work";

  # Generate the complete lua config
  hyprlandLua = ''
    -- ╔══════════════════════════════════════════════════════════════╗
    -- ║  Hyprland Lua Configuration                                  ║
    -- ║  Auto-generated from NixOS configuration                     ║
    -- ║  https://wiki.hypr.land/Configuring/Start/                   ║
    -- ╚══════════════════════════════════════════════════════════════╝

    --------------------
    ---- MONITORS ------
    --------------------
    -- See https://wiki.hypr.land/Configuring/Basics/Monitors/

    ${lib.concatStringsSep "\n" (map monitorToLua config.deviceSettings.monitors)}

    -------------------------
    ---- WORKSPACE RULES ----
    -------------------------

    ${lib.concatStringsSep "\n" (map workspaceToLua config.deviceSettings.monitors)}

    -----------------------
    ---- MY PROGRAMS ------
    -----------------------

    local terminal = "${lib.getExe pkgs.${config.userSettings.terminal}}"
    local mainMod = "SUPER"

    -------------------------------
    ---- ENVIRONMENT VARIABLES ----
    -------------------------------
    -- XDG_CURRENT_DESKTOP, XDG_SESSION_TYPE, XDG_SESSION_DESKTOP are set by UWSM

    ${lib.concatStringsSep "\n" allEnvVars}

    -----------------------
    ---- LOOK AND FEEL ----
    -----------------------

    hl.config({
      general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        layout = "dwindle",
        allow_tearing = ${lib.boolToString isGaming},
        col = {
          active_border = "rgb(44475a)",
          inactive_border = "rgb(282a36)",
        },
      },

      group = {
        groupbar = {
          col = {
            active = { colors = {"rgb(bd93f9)", "rgb(44475a)"}, angle = 90 },
            inactive = "rgba(282a36dd)",
          },
        },
      },

      decoration = {
        rounding = 1,
        blur = {
          enabled = true,
          size = 16,
          passes = 2,
        },
      },

      animations = {
        enabled = true,
      },

      dwindle = {
        preserve_split = true,
      },

      input = {
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
          natural_scroll = false,
        },
      },

      gestures = {
        workspace_swipe_invert = false,
        workspace_swipe_distance = 200,
        workspace_swipe_forever = true,
      },

      misc = {
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        enable_swallow = true,
        disable_hyprland_logo = true,
        initial_workspace_tracking = 0,
        vrr = ${if isGaming then "3" else "0"},
      },

      debug = {
        disable_logs = false,
        enable_stdout_logs = true,
      },
    })

    ${lib.optionalString (config.deviceSettings.type == "vm") ''
    -- VM GPU drivers lack hardware cursor plane support
    hl.config({
      cursor = {
        no_hardware_cursors = true,
        use_cpu_buffer = true,
        hide_on_key_press = false,
      },
    })
    ''}

    ${lib.optionalString isGaming ''
    hl.config({
      cursor = {
        -- Prevent cursor movement from spiking framerate in fullscreen VRR
        no_break_fs_vrr = 2,
      },
      render = {
        -- Direct scanout reduces latency for fullscreen games
        direct_scanout = 2,
        -- Color management + auto HDR in fullscreen
        cm_auto_hdr = 1,
        -- Report content type to allow monitor profile autoswitch
        send_content_type = true,
      },
    })
    ''}

    -------------------------
    ---- ANIMATIONS ---------
    -------------------------

    hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

    hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
    hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
    hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
    hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
    hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
    hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

    -------------------------
    ---- LAYER RULES --------
    -------------------------

    hl.layer_rule({
      name = "waybar-blur",
      match = { namespace = "waybar" },
      blur = true,
      ignore_alpha = 0.2,
      blur_popups = true,
    })

    -------------------------
    ---- WINDOW RULES -------
    -------------------------

    hl.window_rule({
      name = "tile-sioyek",
      match = { class = "^(sioyek)$" },
      tile = true,
    })

    ${lib.optionalString isGaming ''
    -- Allow tearing for Steam games (reduces input latency)
    hl.window_rule({
      name = "steam-tearing",
      match = { class = "^(steam_app_).*$" },
      immediate = true,
    })

    -- Exiled Exchange 2 — PoE2 price-check overlay
    hl.window_rule({
      name = "exiled-exchange-overlay",
      match = { class = "^(exiled-exchange-2)$" },
      float = true,
      pin = true,
      no_focus = true,
      no_initial_focus = true,
    })
    ''}

    -------------------
    ---- AUTOSTART ----
    -------------------

    hl.on("hyprland.start", function()
      hl.exec_cmd("${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store")
      hl.exec_cmd("${pkgs.waytrogen}/bin/waytrogen --restore")
    end)

    ---------------------
    ---- KEYBINDINGS ----
    ---------------------

    -- For the clipboard
    hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("${lib.getExe pkgs.cliphist} list | ${lib.getExe pkgs.rofi} -dmenu | ${lib.getExe pkgs.cliphist} decode | wl-copy"))

    -- Screenshots and recording
    hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("${lib.getExe pkgs.slurp} -w 0 -d | ${lib.getExe pkgs.grim} -g - - | ${lib.getExe pkgs.satty} --filename -"))
    hl.bind(mainMod .. " + R", hl.dsp.exec_cmd('${lib.getExe pkgs.wf-recorder} -al -g "$(${lib.getExe pkgs.slurp} -w 0 -d)" -f $HOME/Recordings/$(date +%Y-%m-%d_%H:%M:%S).mp4 > $HOME/Recordings/$(date +%Y-%m-%d_%H:%M:%S).log'))
    hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("pkill ${lib.getExe pkgs.wf-recorder}"))

    -- General functions
    hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
    hl.bind(mainMod .. " + Q", hl.dsp.window.close())
    hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
    hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
    hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("${lib.getExe pkgs.walker}"))

    -- Project picker: rofi selects a git repo, opens nvim + kiro side by side
    hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("${lib.getExe (pkgs.writeShellScriptBin "project-picker" ''
      repo=$(find "$HOME" -maxdepth 4 -name ".git" -type d 2>/dev/null \
        | sed 's|/.git$||' \
        | sort \
        | ${lib.getExe pkgs.rofi} -dmenu -i -p "Project")

      [ -z "$repo" ] && exit 0

      ${lib.getExe pkgs.${config.userSettings.terminal}} --working-directory="$repo" -e nvim &
      sleep 0.3
      ${lib.getExe pkgs.${config.userSettings.terminal}} --working-directory="$repo" -e kiro-cli chat &
    '')}"))

    -- Move focus with mainMod + arrow keys
    hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
    hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
    hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

    -- Moving windows
    hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
    hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
    hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
    hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

    -- Moving windows between monitors
    hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.workspace.move({ monitor = "l" }))
    hl.bind(mainMod .. " + SHIFT + period", hl.dsp.workspace.move({ monitor = "r" }))

    -- Window resizing
    hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -60, y = 0 }))
    hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 60, y = 0 }))
    hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0, y = -60 }))
    hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0, y = 60 }))

    -- Switch workspaces with mainMod + [0-9]
    -- Move active window to workspace with mainMod + SHIFT + [0-9]
    for i = 1, 10 do
      local key = i % 10 -- 10 maps to key 0
      hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
      hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
    end

    -- Scroll through existing workspaces with mainMod + scroll
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Waybar controls
    hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
    hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill -SIGUSR2 waybar"))

    ${lib.optionalString isWork ''
    -- Work profile: toggle laptop display
    hl.bind(mainMod .. " + T", hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, disable"'))
    hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd('hyprctl keyword monitor "${last_monitor.name},${toString last_monitor.width}x${toString last_monitor.height}@${fmtRate last_monitor.refreshRate},${last_monitor.position},1"'))
    hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("hyprctl reload"))
    ''}
  '';
in {
  # Instead of using wayland.windowManager.hyprland.settings (which generates hyprlang),
  # we place the lua config file directly. The Home Manager module still handles
  # enabling Hyprland and setting up the package/systemd integration.
  wayland.windowManager.hyprland = lib.mkForce {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
    configType = "lua";
  };

  # Place the generated lua config
  xdg.configFile."hypr/hyprland.lua".text = hyprlandLua;

  # Systemd user services for processes previously in exec-once
  systemd.user.services.waytrogen = {
    Unit = {
      Description = "Restore wallpaper with waytrogen";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.waytrogen}/bin/waytrogen --restore";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
