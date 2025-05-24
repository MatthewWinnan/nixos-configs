# NB Remember do not map ATL-><vim_nav>
{
  config,
  pkgs,
  lib,
  ...
}: let
  last_monitor = lib.lists.last config.deviceSettings.monitors;
in {
  wayland.windowManager.hyprland = lib.mkForce {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
    };

    # We need to use an old compatible package
    #package = pinnedHyprland;

    settings = {
      "$mainMod" = "ALT";
      "$terminal" = "kitty";

      monitor = map (
        m: "${m.name},${
          if m.enabled
          then "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},1"
          else "disable"
        }"
      ) (config.deviceSettings.monitors);

      workspace = map (
        m: lib.optionalString m.enabled "${m.workspace},monitor:${m.name},default:true"
      ) (config.deviceSettings.monitors);

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,~/screens"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      ];

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 4;

        layout = "dwindle";

        # darker alternative
        "col.active_border" = "rgb(44475a)"; # or rgb(6272a4)
        "col.inactive_border" = "rgb(282a36)";
      };
      group = {
        groupbar = {
          "col.active" = "rgb(bd93f9) rgb(44475a) 90deg";
          "col.inactive" = "rgba(282a36dd)";
        };
      };

      decoration = {
        rounding = 1;

        # Does not exist since Hyprland 0.47.2 built from branch v0.47.2-b at commit 882f7ad7d2bbfc7440d0ccaef93b1cdd78e8e3ff
        #suggested shadow setting
        # drop_shadow = true;
        #"col.shadow" = "rgba(1E202966)";
        # shadow_offset = "1 2";
        # shadow_range = 60;
        # shadow_render_power = 3;
        # shadow_scale = 0.97;

        blur = {
          enabled = true;
          size = 16;
          passes = 2;
          new_optimizations = true;
        };
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        # bezier = "myBezier, 0.33, 0.82, 0.9, -0.08";

        animation = [
          "windows,     1, 7,  myBezier"
          "windowsOut,  1, 7,  default, popin 80%"
          "border,      1, 10, default"
          "borderangle, 1, 8,  default"
          "fade,        1, 7,  default"
          "workspaces,  1, 6,  default"
        ];
      };

      dwindle = {
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_invert = false;
        workspace_swipe_distance = 200;
        workspace_swipe_forever = true;
      };

      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        render_ahead_of_time = false;
        disable_hyprland_logo = true;
        initial_workspace_tracking = 2;
      };

      windowrule = [
        "float, ^(imv)$"
        "float, ^(mpv)$"
      ];

      # Since NixOS 25.05 hyprpaper keeps conflicting with swww, I need to rather use hyprpaper as the backend, I suspect this is due to sylix
      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.waypaper}/bin/waypaper --restore --backend hyprpaper"
        "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"

        # I might be doing something wrong but this does break my normal copy and paste
        #"${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both"
      ];

      bind =
        [
          # For the warpd keybindings see -> https://github.com/rvaiya/warpd?tab=readme-ov-file#wayland
          # Sucks does not work maybe due to https://www.reddit.com/r/linux/comments/1eaxgy4/hyprland_has_become_independent_dropping_wlroots/
          #"$mainMod SHIFT, X, exec, ${lib.getExe pkgs.warpd} --hint"
          #"$mainMod SHIFT, C, exec, ${lib.getExe pkgs.warpd} --normal"
          #"$mainMod SHIFT, G, exec, ${lib.getExe pkgs.warpd} --grid"

          # For the clip board
          "$mainMod, C, exec, ${lib.getExe pkgs.cliphist} list | ${lib.getExe pkgs.rofi} -dmenu | ${lib.getExe pkgs.cliphist} decode | wl-copy"

          # For screen shotting and recording
          "$mainMod, P, exec, ${lib.getExe pkgs.slurp} -w 0 -d | ${lib.getExe pkgs.grim} -g - - | ${lib.getExe pkgs.swappy} -f - -o $HOME/Pictures/$(date +%Y-%m-%d_%H:%M:%S).png"
          ''$mainMod, R, exec, ${lib.getExe pkgs.wf-recorder} -al -g "$(${lib.getExe pkgs.slurp} -w 0 -d)" -f $HOME/Recordings/$(date +%Y-%m-%d_%H:%M:%S).mp4 > $HOME/Recordings/$(date +%Y-%m-%d_%H:%M:%S).log ''
          "$mainMod SHIFT, R, exec, pkill ${lib.getExe pkgs.wf-recorder}"
          # General functions
          "$mainMod, Return, exec, ${lib.getExe pkgs.kitty}"
          "$mainMod, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, F, fullscreen,"
          "$mainMod, D, exec, rofi -show drun"

          # Move focus with mainMod + arrow keys
          "$mainMod, left,  movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up,    movefocus, u"
          "$mainMod, down,  movefocus, d"

          # Moving windows
          "$mainMod SHIFT, left,  swapwindow, l"
          "$mainMod SHIFT, right, swapwindow, r"
          "$mainMod SHIFT, up,    swapwindow, u"
          "$mainMod SHIFT, down,  swapwindow, d"

          # Moving windowszs between monitors
          "$mainMod SHIFT, comma, movecurrentworkspacetomonitor, l"
          "$mainMod SHIFT, period, movecurrentworkspacetomonitor, r"

          # Window resizing                     X  Y
          "$mainMod CTRL, left,  resizeactive, -60 0"
          "$mainMod CTRL, right, resizeactive,  60 0"
          "$mainMod CTRL, up,    resizeactive,  0 -60"
          "$mainMod CTRL, down,  resizeactive,  0  60"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
          "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          # Keyboard backlight
          #"$mainMod, F3, exec, brightnessctl -d *::kbd_backlight set +33%"
          #"$mainMod, F2, exec, brightnessctl -d *::kbd_backlight set 33%-"

          # Volume and Media Control
          #", XF86AudioRaiseVolume, exec, pamixer -i 5 "
          #", XF86AudioLowerVolume, exec, pamixer -d 5 "
          #", XF86AudioMute, exec, pamixer -t"
          #", XF86AudioMicMute, exec, pamixer --default-source -m"

          # Brightness control
          #", XF86MonBrightnessDown, exec, brightnessctl set 5%- "
          #", XF86MonBrightnessUp, exec, brightnessctl set +5% "

          # Configuration files
          #''$mainMod SHIFT, N, exec, alacritty -e sh -c "rb"''
          #''$mainMod SHIFT, C, exec, alacritty -e sh -c "conf"''
          #''$mainMod SHIFT, H, exec, alacritty -e sh -c "nvim ~/nix/home-manager/modules/wms/hyprland.nix"''
          #''$mainMod SHIFT, W, exec, alacritty -e sh -c "nvim ~/nix/home-manager/modules/wms/waybar.nix''
          #'', Print, exec, grim -g "$(slurp)" - | swappy -f -''

          # Waybar
          "$mainMod, B, exec, pkill -SIGUSR1 waybar"
          "$mainMod, W, exec, pkill -SIGUSR2 waybar"
        ]
        ++ lib.optionals (config.systemSettings.profile == "work") [
          # Allows me to toggle the display if I am on my work
          ''$mainMod, T, exec, hyprctl keyword monitor "eDP-1, disable"''
          # Allows me to turn the built in laptop monitor on again
          ''$mainMod SHIFT, T, exec, hyprctl keyword monitor "${last_monitor.name},${toString last_monitor.width}x${toString last_monitor.height}@${toString last_monitor.width},${last_monitor.position},1"''
          # We have to reload the config to make sure it takes effect...
          "$mainMod SHIFT, O, exec, hyprctl reload"
        ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
