{pkgs, ...}: {
  programs = {
    # show network usage
    bandwhich.enable = true;

    # registry for linux, thanks to gnome
    dconf.enable = true;

    # gnome's keyring manager
    seahorse.enable = true;

    # networkmanager tray uility
    nm-applet.enable = true;
  };
}
