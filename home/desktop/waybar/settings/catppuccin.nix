{pkgs, ...}:{
      mainBar = {
        layer = "top";
        position = "top";
        margin = "9 13 -10 10";

        modules-left = ["hyprland/workspaces"];
        modules-center = ["custom/weather"];
        modules-right = ["pulseaudio" "custom/mem" "cpu" "clock" "tray" "custom/lock" "custom/power"];

        "hyprland/workspaces" = {
          disable-scroll = true;
          sort-by-name = true;
          format = " {icon} ";
          format-icons = {
            "default" = "";
          };
        };

        "hyprland/language" = {
          format-en = "US";
          min-length = 5;
          tooltip = false;
        };

        "keyboard-state" = {
          #numlock = true;
          capslock = true;
          format = "{icon} ";
          format-icons = {
            locked = " ";
            unlocked = "";
          };
        };

        "clock" = {
          # timezone = "America/New_York";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          # format = "{:%a; %d %b, %I:%M %p}"; Old legacy format
          format-alt = "📅 {:%d/%m/%Y}";
          format = " {:%H:%M}";
        };

        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 1800;
          exec = "${pkgs.wttrbar}/bin/wttrbar --location Centurion";
          return-type = "json";
        };

        "pulseaudio" = {
          # scroll-step = 1; # %, can be a float
          reverse-scrolling = 1;
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" " "];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          # min-length = 13;
        };

        "custom/mem" = {
          format = "{} ";
          interval = 3;
          exec = "free -h | awk '/Mem:/{printf $3}'";
          tooltip = false;
        };

        "custom/lock" = {
          tooltip = false;
          on-click = "sleep 0.5s; hyprlock --immediate & disown";
          format = "";
        };

        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "⏻";
        };

        "cpu" = {
          interval = 2;
          format = "{usage}% ";
          min-length = 6;
        };

        "temperature" = {
          # thermal-zone = 2;
          # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          # format-critical = "{temperatureC}°C {icon}";
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" "" "" ""];
          tooltip = false;
        };

        "backlight" = {
          device = "intel_backlight";
          format = "{percent}% {icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" "" "" "" "" "" ""];
          # on-update = "$HOME/.config/waybar/scripts/check_battery.sh";
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    }
