{config, ...}: {
  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "qutebrowser";
    TERMINAL = "kitty";
    GSETTINGS_BACKEND = "keyfile";
    NH_FLAKE = "/home/${config.userSettings.username}/NIX_REPO";

    # Desktop settings
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XCURSOR_SIZE = "24";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    XDG_SCREENSHOTS_DIR = "~/Media/Pictures";
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
  };
}
