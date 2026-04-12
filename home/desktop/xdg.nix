{
  config,
  pkgs,
  lib,
  ...
}: let
  browser = ["org.qutebrowser.qutebrowser.desktop"];
  pdf = ["sioyek.desktop"];
  image = ["imv.desktop"];
  markdown = ["typora.desktop"];
  fallback = ["org.gnome.Evince.desktop"];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.desktop"];

    # Images - imv
    "image/*" = image;
    "image/png" = image;
    "image/jpeg" = image;
    "image/gif" = image;
    "image/webp" = image;
    "image/bmp" = image;
    "image/tiff" = image;

    # PDF - Sioyek
    "application/pdf" = pdf;

    # Markdown - Typora
    "text/markdown" = markdown;
    "text/x-markdown" = markdown;

    # Fallback document types - Evince
    "application/postscript" = fallback;
    "application/x-dvi" = fallback;
    "image/vnd.djvu" = fallback;
    "application/x-cbr" = fallback;
    "application/x-cbz" = fallback;
    "application/epub+zip" = fallback;
    "application/x-fictionbook+xml" = fallback;

    "application/json" = browser;
  };

in {
  #home.sessionVariables = template.sysEnv;

  gtk.gtk4.theme = null;

  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = ["gtk"];
        hyprland.default = ["gtk" "hyprland"];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };

    userDirs = {
      enable = pkgs.stdenv.isLinux;
      createDirectories = true;

      download = "${config.home.homeDirectory}/Downloads";
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";

      publicShare = "${config.home.homeDirectory}/.local/share/public";
      templates = "${config.home.homeDirectory}/.local/share/templates";

      music = "${config.home.homeDirectory}/Media/Music";
      pictures = "${config.home.homeDirectory}/Media/Pictures";
      videos = "${config.home.homeDirectory}/Media/Videos";
    };

    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
