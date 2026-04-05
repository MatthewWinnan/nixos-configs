# Omarchy-inspired waybar configuration
# https://github.com/basecamp/omarchy
{pkgs, ...}: {
  mainBar = {
    reload_style_on_change = true;
    layer = "top";
    position = "top";
    spacing = 0;
    height = 26;

    modules-left = ["custom/launcher" "hyprland/workspaces"];
    modules-center = ["clock" "custom/screenrecord" "custom/idle" "custom/notification"];
    modules-right = [
      "tray"
      "bluetooth"
      "network"
      "pulseaudio"
      "cpu"
      "battery"
    ];

    "hyprland/workspaces" = {
      on-click = "activate";
      format = "{icon}";
      format-icons = {
        default = "";
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "0";
        active = "󱓻";
      };
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
    };

    "custom/launcher" = {
      format = "󱄅";
      tooltip-format = "Application Launcher";
      on-click = "${pkgs.rofi}/bin/rofi -show drun";
      on-click-right = "${pkgs.ghostty}/bin/ghostty";
    };

    clock = {
      format = "{:%A %H:%M}";
      format-alt = "{:%d %B W%V %Y}";
      tooltip = false;
    };

    cpu = {
      interval = 5;
      format = "󰍛";
      tooltip-format = "CPU: {usage}%";
      on-click = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop";
    };

    network = {
      format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
      format = "{icon}";
      format-wifi = "{icon}";
      format-ethernet = "󰀂";
      format-disconnected = "󰤮";
      tooltip-format-wifi = "{essid} ({frequency} GHz)";
      tooltip-format-ethernet = "Connected via {ifname}";
      tooltip-format-disconnected = "Disconnected";
      interval = 3;
      on-click = "${pkgs.kitty}/bin/kitty ${pkgs.networkmanager}/bin/nmtui";
    };

    battery = {
      format = "{capacity}% {icon}";
      format-discharging = "{icon}";
      format-charging = "{icon}";
      format-plugged = "";
      format-icons = {
        charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
        default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      };
      format-full = "󰂅";
      tooltip-format-discharging = "{power:.1f}W | {capacity}%";
      tooltip-format-charging = "{power:.1f}W | {capacity}%";
      interval = 5;
      on-click = "${pkgs.wlogout}/bin/wlogout";
      states = {
        warning = 20;
        critical = 10;
      };
    };

    bluetooth = {
      format = "";
      format-off = "󰂲";
      format-disabled = "󰂲";
      format-connected = "󰂱";
      format-no-controller = "";
      tooltip-format = "Devices connected: {num_connections}";
      tooltip-format-connected = "{device_alias}";
      on-click = "${pkgs.kitty}/bin/kitty ${pkgs.bluetuith}/bin/bluetuith";
    };

    pulseaudio = {
      format = "{icon}";
      on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      on-click-right = "${pkgs.pamixer}/bin/pamixer -t";
      tooltip-format = "Volume: {volume}%";
      scroll-step = 5;
      format-muted = "";
      format-icons = {
        headphone = "";
        headset = "";
        default = ["" "" ""];
      };
    };

"custom/screenrecord" = {
      format = "{}";
      exec = ''
        if pgrep -x wf-recorder > /dev/null; then
          echo '{"text": "󰻂", "class": "active", "tooltip": "Recording..."}'
        else
          echo '{"text": "", "class": "hidden"}'
        fi
      '';
      return-type = "json";
      interval = 2;
      on-click = "pkill wf-recorder || wf-recorder -f ~/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4";
    };

    "custom/idle" = {
      format = "{}";
      exec = ''
        if pgrep -x hypridle > /dev/null; then
          echo '{"text": "", "class": "hidden"}'
        else
          echo '{"text": "󰛊", "class": "active", "tooltip": "Idle inhibited"}'
        fi
      '';
      return-type = "json";
      interval = 5;
      on-click = "pkill hypridle || hypridle &";
    };

    "custom/notification" = {
      format = "{}";
      exec = ''
        mode=$(${pkgs.mako}/bin/makoctl mode)
        if echo "$mode" | grep -q "do-not-disturb"; then
          echo '{"text": "󰂛", "class": "active", "tooltip": "Do Not Disturb"}'
        else
          echo '{"text": "", "class": "hidden"}'
        fi
      '';
      return-type = "json";
      interval = 2;
      on-click = "${pkgs.mako}/bin/makoctl mode -t do-not-disturb";
    };

    tray = {
      icon-size = 12;
      spacing = 17;
    };
  };
}
