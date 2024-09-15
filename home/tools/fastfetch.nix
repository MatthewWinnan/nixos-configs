{config, ...}:{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
      source = config.images.fastfetch_logo;
      type = "kitty";
      width = 50;
      height = 25;
  };
  "modules" = [
    "title"
    "separator"
    "os"
    "host"
    "kernel"
    "uptime"
    "packages"
    "shell"
    "display"
    "de"
    "wm"
    "wmtheme"
    "theme"
    "icons"
    "font"
    "cursor"
    "terminal"
    "terminalfont"
    "cpu"
    "gpu"
    "memory"
    "swap"
    "disk"
    "localip"
    "battery"
    "poweradapter"
    "locale"
    "break"
    "colors"
  ];

    };
  };
}
