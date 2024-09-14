{lib, pkgs, ...}:{
  # We need to override stylix mostly
  programs.waybar = lib.mkForce {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "9 13 -10 10";

        modules-left = ["hyprland/workspaces"];
        modules-center = ["custom/weather"];
        modules-right = ["pulseaudio" "custom/mem" "cpu" "clock" "custom/lock" "custom/power" "tray"];

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
        format-ru = "RU";
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
        on-click = "pavucontrol";
          # min-length = 13;
    };

    "custom/mem" = {
        format = "{} ";
        interval = 3;
        exec = "free -h | awk '/Mem:/{printf $3}'";
        tooltip = false;
        };

    "custom/lock" = {
        tooltip =  false;
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
    }; 
    style = 
      ''
@define-color base   #24273a;
@define-color mantle #1e2030;
@define-color crust  #181926;

@define-color text     #cad3f5;
@define-color subtext0 #a5adcb;
@define-color subtext1 #b8c0e0;

@define-color surface0 #363a4f;
@define-color surface1 #494d64;
@define-color surface2 #5b6078;

@define-color overlay0 #6e738d;
@define-color overlay1 #8087a2;
@define-color overlay2 #939ab7;

@define-color blue      #8aadf4;
@define-color lavender  #b7bdf8;
@define-color sapphire  #7dc4e4;
@define-color sky       #91d7e3;
@define-color teal      #8bd5ca;
@define-color green     #a6da95;
@define-color yellow    #eed49f;
@define-color peach     #f5a97f;
@define-color maroon    #ee99a0;
@define-color red       #ed8796;
@define-color mauve     #c6a0f6;
@define-color pink      #f5bde6;
@define-color flamingo  #f0c6c6;
        @define-color rosewater #f4dbd6;

        * {
  font-family: Hack Nerd Font;
  font-size: 17px;
  min-height: 0;
}

#waybar {
  background: transparent;
  color: @text;
  margin: 5px 5px;
}

#workspaces {
  border-radius: 1rem;
  margin: 5px;
  background-color: @surface0;
  margin-left: 1rem;
}

#workspaces button {
  color: @lavender;
  border-radius: 1rem;
  padding: 0.4rem;
}

#workspaces button.active {
  color: @sky;
  border-radius: 1rem;
}

#workspaces button:hover {
  color: @sapphire;
  border-radius: 1rem;
        }

#tray,
#backlight,
#clock,
#battery,
#pulseaudio,
#custom-lock,
#custom-weather,
#custom-mem,
#cpu,
#keyboard-state,
#custom-power {
  background-color: @surface0;
  padding: 0.5rem 1rem;
  margin: 5px 0;
  opacity: 0.8;
}


#keyboard-state {
  transition: none;
  color: @lavender;
  border-radius: 0px 1rem 1rem 0px;

}

#custom-weather {
    color: @lavender;
  transition: none;
    border-radius: 1rem;
}

#clock {
  color: @blue;
  border-radius: 0px 1rem 1rem 0px;
  margin-right: 1rem;
}

#battery {
  color: @green;
}

#battery.charging {
  color: @green;
}

#battery.warning:not(.charging) {
  color: @red;
}

#backlight {
  color: @yellow;
}

#backlight, #battery {
    border-radius: 0;
}

#pulseaudio {
  color: @pink;
  border-radius: 1rem 0px 0px 1rem;
  margin-left: 1rem;
        }

        #custom-lock {
    border-radius: 1rem 0px 0px 1rem;
    color: @lavender;
}

#custom-power {
    margin-right: 1rem;
    border-radius: 0px 1rem 1rem 0px;
    color: @blue;
}

#tray {
  margin-right: 1rem;
  border-radius: 1rem;
}

      '';
  };
}
