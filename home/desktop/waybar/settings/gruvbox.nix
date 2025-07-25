{pkgs, ...}: {
  mainBar = {
    layer = "top";
    spacing = 0;
    height = 0;

    margin = "9 13 -10 10";

    # margin-top = 8;
    # margin-right = 8;
    # margin-bottom = 0;
    # margin-left = 8;

    modules-left = ["hyprland/workspaces"];
    modules-center = ["clock"];
    modules-right = [
      "tray"
      "cpu_text"
      "cpu"
      "memory"
      "battery"
      "network"
      "pulseaudio"
    ];

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      tooltip = false;
    };

    tray = {
      spacing = 10;
      tooltip = false;
    };

    clock = {
      format = "{:%I:%M %p - %a, %d %b %Y}";
      tooltip = false;
    };

    cpu = {
      format = "cpu {usage}%";
      interval = 2;
      states = {
        critical = 90;
      };
    };

    memory = {
      format = "mem {percentage}%";
      interval = 2;
      states = {
        critical = 80;
      };
    };

    battery = {
      format = "bat {capacity}%";
      interval = 5;
      states = {
        warning = 20;
        critical = 10;
      };
      tooltip = false;
    };

    network = {
      format-wifi = "wifi {bandwidthDownBits}";
      format-ethernet = "enth {bandwidthDownBits}";
      format-disconnected = "no network";
      interval = 5;
      tooltip = false;
    };

    pulseaudio = {
      scroll-step = 5;
      max-volume = 150;
      format = "vol {volume}%";
      format-bluetooth = "vol {volume}%";
      nospacing = 1;
      on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      tooltip = false;
    };
  };
}
